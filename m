Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9DD6DC28E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 04:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjDJCLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 22:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJCLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 22:11:00 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCA12D58;
        Sun,  9 Apr 2023 19:11:00 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id 20so5365227plk.10;
        Sun, 09 Apr 2023 19:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681092659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ggo07Sea6S7Zjph1aw4SnB7bJGa7ySeh9EDO3YMcUps=;
        b=ereIpum2iAP/fi40fA6lD8NOFsfeuV3KMLaHIMuKp8mW77dZ/pXQwFJAIujtIs+VDs
         4P9AKtpgskCfyu/7LagRWwlM8dZMGZMLpo8HRZaqxxV2qdzLo9V95snHzpEQY3U2iLM0
         XBwxDlWmhwTx6D18Ds9wuiz1FhZP+LuhL63Q8fFNEWFLniNLOEJDyvyO97ieLQffIFVX
         np8uK2XUSKI0Sdk/dPgysbtMu/aXSyK4JwnXZR2Okvp+30PEWeSAl8CWSsuNAwKJlVbK
         477Df5E/q1MJF4042l5b4zao3qMjs1LqQeDwcBR+4q0KVLOsMPfYsw5QKw7vpLmRULsa
         E1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681092659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ggo07Sea6S7Zjph1aw4SnB7bJGa7ySeh9EDO3YMcUps=;
        b=wKNtC6+PqpOnh4eRJRQxZ/MDTsv41TVN9yHMPJ9FcbfHpfEmehWadiQF3sR2HRZwfW
         kLhm+pWfcqwk/DD9j0uOP0MmZRBZ8KZzZhyZjvlW0TIkg/rvaHOlQusOPZEJNJ0ywk22
         e4wAc0enepemz+5v6T25Csi+Mw8MjBdx/K8jsGxxH5BCKMSWXnmw7NJ2wD6fk2MKiaQJ
         RajxYdDG3wXAk9ETaAXOnph79xgzZYMhQhUR30lQLeIWZ+xWq/8mfXy4BF0NXosPQrOa
         cx3wJYox9n1S1B3j3K8K5JhQ6jRsM9rZ2Rq/g5eWPkc7+WyRZIu6Y06HoeGp/0cOPDQs
         iz8w==
X-Gm-Message-State: AAQBX9cGILwX/+EE24+dZR9P3aBEuZ+QA/l0NWSkIGWMlGqtNFEDv69h
        JbH3Q9Z/fIgVD2Z+0cW6LhQ=
X-Google-Smtp-Source: AKy350Zew+RUwzhLYypxOcndmWAiTB80rjjavywCywuYAEJhRlxsSw++2RKi4bxITJaGbzsSGruXRw==
X-Received: by 2002:a17:902:e889:b0:19a:a815:2858 with SMTP id w9-20020a170902e88900b0019aa8152858mr13524712plg.51.1681092659353;
        Sun, 09 Apr 2023 19:10:59 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:803c:4683:913e:ce04])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902b20400b001a64851087bsm2124plr.272.2023.04.09.19.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 19:10:58 -0700 (PDT)
Date:   Sun, 9 Apr 2023 19:10:56 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH v2] Input: cma3000_d0x - Remove duplicate code
Message-ID: <ZDNwMDoBO0IjM7lM@google.com>
References: <20230407021343.63512-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407021343.63512-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 10:13:43AM +0800, Jiapeng Chong wrote:
> Function input_set_abs_params() has already set EV_ABS bit for us.
> 
> drivers/input/misc/cma3000_d0x.c:328 cma3000_init() warn: inconsistent indenting.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4588
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Applied, thank you.

-- 
Dmitry
