Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A29F62B02D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 01:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiKPAkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 19:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiKPAkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 19:40:15 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E452C674
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 16:40:14 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-13bd19c3b68so18297683fac.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 16:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lQT+j5hdzGfE1l14JY4Uf0FVeNfG/68KrbfSmguSC+Q=;
        b=UA7WiuZ98uEwXpJleiiXUYhmb9+UwSB8txAwjgslkMHMSA2eltPR5ofSS13rlI3gVi
         4Ca0OYbRKBm5HUhu/wkhkCuS/E7SGRK7zTBz5bkAgZtc8LDtbETWfJB1RvayXg/SeSEM
         Kv7ZAMzXpGUSwqtZrnGn+yPhw+stpHqGQWCpoImcbGcaSLSElLCy39lJj4aysNgnb0IE
         j76PiXnHhpBHR4ImUWpoYF6nAKp5y6f+/akJPQuwhBvbPD3/oOIZxEuBZKWrH6d9ivuD
         bvPCoYkZbF3RVBY6QPFLkxeuViQet8+pbHYOVjB1GuRT65NReeCnTTZDEoGPrqZownIV
         zoyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQT+j5hdzGfE1l14JY4Uf0FVeNfG/68KrbfSmguSC+Q=;
        b=mov/NAgERHNIsv2ZmjC5IXe/r3omF01IfwrUHOivdqUvkl0HRLZxCW6MQ3UgOISeLy
         7CjCrVwXigd0EgINr0iI57bfnZhG1ocMhoiQrtJNmnZnVV1875b92iSeYbeQM83+jXgU
         NQvOVUMLoeWj5ok23qdwPaiT1CyEpHwLk5h/1O2rhxdGHexITNt9WvJUTGkRzEPzzu5a
         bzQ/tE35cz7hjmrZGLbRFTy4oLxXrlI7wC1ZvoVCCUPaA9hKDsHrMWh48MbpSlzKUvkz
         fyeXzF9dJ4LMePgh6U6jHDOp5bToRu4nSbk1WXhx//KtksD25zfmQ4094kDJhZehUrWi
         YGNg==
X-Gm-Message-State: ANoB5pnXkXL6eLWbtZ7Go3uEp1YoiHILS9M++9rbencEDG5E1jRaINuN
        KV6kIbjBCpYN5XHE3iU0QAPj6oRkPKS0WrGfUoC3LQ==
X-Google-Smtp-Source: AA0mqf5gcNnc+lOsaLj3LIpF4Gxs7IzosfXYLhxtUdn1pal/rMV2uOpq1r7K4BFv/EgeOk4FtjVnaMUiAoJxC4LId6U=
X-Received: by 2002:a05:6870:6a94:b0:136:82f6:7ece with SMTP id
 mv20-20020a0568706a9400b0013682f67ecemr493702oab.271.1668559213981; Tue, 15
 Nov 2022 16:40:13 -0800 (PST)
MIME-Version: 1.0
References: <20221104230040.2346862-1-dionnaglaze@google.com>
 <20221104230040.2346862-5-dionnaglaze@google.com> <b332c967-cbe5-891a-3d15-f9fbb514d8e6@amd.com>
 <CAAH4kHY-zq_WrZK1-Jne8LURwY5K_6orK3NuZbVn9u+gwQdN=w@mail.gmail.com>
In-Reply-To: <CAAH4kHY-zq_WrZK1-Jne8LURwY5K_6orK3NuZbVn9u+gwQdN=w@mail.gmail.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Tue, 15 Nov 2022 16:40:03 -0800
Message-ID: <CAAH4kHaq+vNRkQRA9WX_V+R_hoXn3SKcRfJcyd2ddJqQ8ZzmkQ@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] virt: sev-guest: interpret VMM errors from guest request
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Gonda <pgonda@google.com>, Borislav Petkov <bp@suse.de>,
        Liam Merwick <liam.merwick@oracle.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Haowen Bai <baihaowen@meizu.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the top post.

-- 
-Dionna Glaze, PhD (she/her)
