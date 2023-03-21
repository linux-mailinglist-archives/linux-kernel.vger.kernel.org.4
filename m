Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A5E6C2916
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 05:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjCUEVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 00:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCUEVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 00:21:40 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0996E1E9C5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 21:21:39 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e18so802942wra.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 21:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679372497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FaA3YcfbP2IfbH5dMI6u00735TG6aAqY5ouGiTU+WFk=;
        b=EtrMWxnRRahazbpCMKjpmWwtsarzSHOaV8RTrJMK4Tieua8mA6870vyBXSdwgZpLww
         Q7rqQD6789WQ4Yks+JOYwjL2jyoF+GUokGtRiuO9eqY3+AgR8RZKScux+Ivjcrn3IkUS
         R3jNV5C4BTMMY0RcEN0c2H0H8NfAVbBAwf4gYPHYEJylP44mBULHDtp8Mw1CT5nQ6Nwj
         /0Fp+Y/rVk01hdpNoVgeEkmGwTgcU4i2QUlMJw3IADa5RlpQK/htT4/xydc6PKAlkPEi
         99a4VkdCezsLRgm5zNtNUdo1zFPQFqv0YYW2dAiYFbMyMurMJekoKPV07X2xcbpt8n10
         FL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679372497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaA3YcfbP2IfbH5dMI6u00735TG6aAqY5ouGiTU+WFk=;
        b=vL4QdoW+LwPCH9BXb7ofj9MKFPp/WN23Hgxyv2F8F0SpaLMjk2sJzQPZOu4clpxVOj
         OFSe9ElZrYn6AACxj92NgpaQGjalSI3urnV2KEgzR2EDMC3BgOqg3wc7xtNk2W1LM2Ws
         +b+tRC6CWsaddgJSx3PLECiLWwjlaLOXjJqqdA+or6CaGuWEcKRx/T4l2WKp+NIO5im6
         t8pBZ9o+k+vZErzxFt1I51G+tc0kQA1d/DgHLGYePAUNFUug9hkusTydM77IIxbIpXma
         oiGsws3BGC0JxL/sWGsEVqy+JswjeDGfJMB/ZDQ3QZKOQ2K5Ys0Aj19agCG1mUMAZtai
         zb2Q==
X-Gm-Message-State: AO0yUKXVjnjfjrXd613n6rlxHZCr8WzHsr2Tu/LYfGbxE4j44UEZhlTm
        QHskIasu0cECbPjFbG8CM/M=
X-Google-Smtp-Source: AK7set9mZGHw3yoEvNxRRdaPhFjETeu4dlT4c5n8MfQKVOlfTRsqWB//SFmS1Q1Nlouet/QTsHbrfg==
X-Received: by 2002:a05:6000:541:b0:2d8:ce83:5de0 with SMTP id b1-20020a056000054100b002d8ce835de0mr903209wrf.48.1679372497306;
        Mon, 20 Mar 2023 21:21:37 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e4-20020a5d4e84000000b002ceac2ccc4asm10317162wru.23.2023.03.20.21.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 21:21:35 -0700 (PDT)
Date:   Tue, 21 Mar 2023 07:21:31 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Kloudifold <cloudifold.3125@gmail.com>, outreachy@lists.linux.dev,
        teddy.wang@siliconmotion.com, sudipm.mukherjee@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, alison.schofield@intel.com
Subject: Re: [PATCH v3] staging: sm750: Rename sm750_hw_cursor_* functions to
 snake_case
Message-ID: <713dea35-3db7-4898-912d-b52ecab0a420@kili.mountain>
References: <ZBW+NX4SLaCyEnJd@CloudiRingWorld>
 <dd1e1fcc-2a4e-438f-ad61-ef7640b8e423@kili.mountain>
 <6418ca43e651b_2c274e294ae@iweiny-mobl.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6418ca43e651b_2c274e294ae@iweiny-mobl.notmuch>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fair enough.  Also I wouldn't have said anything if the patch had been
checkpatch clean.  I was testing to see if the extra --- lines mattered
and that's when git complained about white space problems and it's like
you say, the extra --- lines don't cause an issue.

regards,
dan carpenter

