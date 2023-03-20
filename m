Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850C56C0A5A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 07:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjCTGFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 02:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjCTGF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 02:05:29 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417B81F93B;
        Sun, 19 Mar 2023 23:05:25 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id ja10so11348653plb.5;
        Sun, 19 Mar 2023 23:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679292325;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gdcw4xkODe26qb5DhyCiLTdB8qeORn1LyUUiJpkNw9A=;
        b=MUavQoQFazHGbdkwyG8K1ScJtWu+6B/lU2NVL9fAVyzSoVoqorgsWHo0ymaS+O74GH
         a2uxh+VDoCwpd8FDrZQ+zOhpOeph47VnViiszs3E27xNENjHlwWgnqA5zpocA7VDiPpW
         FY7K+klyBV295KKYN2iyMAEBsFLiHwxmbLRnQrCdV0rU0I96sFtM0/q0tgd9G4HTQpYG
         fmuDcj6hDWkF4gUW78AHH5QfvNEtzoppiZ+bSUO2yU4Vu6RVXI7miVFvuIiQcP7ZiTwX
         2G9HblKjS1rLXBeFFcaxlCfKzZc1WRvB+yEGDHQR9kzTW9XKVHfMq4zENIVYpmQ0naW8
         wPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679292325;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gdcw4xkODe26qb5DhyCiLTdB8qeORn1LyUUiJpkNw9A=;
        b=wnDFnFsHutW1UAgV6cot0nptdOQg3qsRBnrFfoCH/Ad3Rm6pmzeV39knp7haZLFvBt
         GAN9aUebJ99DV/sLScUBJA54DaU7RzrBZlV/PS55NAcTTPF8P5EKfAPaNJJ0fkyEEAs2
         ZdpWI/sii6UfWScuIlrAf8AmaFCvbdZDVsLG0xNXtRt9cAe7gr2XVv1e4oymMxfn5plu
         mgOGR+fjUgtDdvqv90PBLQn4MV+N4uyjDiE+rzz4cBBffvFDiwmJKoNIKjKQ2mAvzr1n
         arvew3ExZIUv3NQNdB2K8wc1ubSrqVNgAXOIUDYLf1lQ0XrplpJx/oyQux9BwQ9XCBdB
         8Srg==
X-Gm-Message-State: AO0yUKWgjp2RZvwPnkHAC83T8fQlaKl9oguy605iV+pneJ2J6qcn6UmM
        QGiDmf30qWGxCBWT+f3En6c=
X-Google-Smtp-Source: AK7set8tjrk4xHxHYzusuAoxtfY2b5/8Iv/YZ7qDNeaEK7RrkEVRi/RwgwsNbq3fr9uomCk8U+W4/A==
X-Received: by 2002:a17:902:ce85:b0:19c:f8c5:d504 with SMTP id f5-20020a170902ce8500b0019cf8c5d504mr16083288plg.59.1679292324655;
        Sun, 19 Mar 2023 23:05:24 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:687c:5175:b0b1:a145])
        by smtp.gmail.com with ESMTPSA id bi11-20020a170902bf0b00b0019f11caf11asm5734306plb.166.2023.03.19.23.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 23:05:24 -0700 (PDT)
Date:   Sun, 19 Mar 2023 23:05:21 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org,
        Hillf Danton <hdanton@sina.com>, cocci@inria.fr,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: iforce - Fix exception handling in
 iforce_usb_probe()
Message-ID: <ZBf3oSgJP8bLmhG0@google.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <521b63e1-9470-58ef-599e-50a1846e5380@web.de>
 <ZBffPEIWcmYcaXR3@google.com>
 <6b5de584-b31f-9045-a438-b42da350326b@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b5de584-b31f-9045-a438-b42da350326b@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 01:34:52PM +0900, Tetsuo Handa wrote:
> On 2023/03/20 13:21, Dmitry Torokhov wrote:
> > On Sun, Mar 19, 2023 at 07:03:00PM +0100, Markus Elfring wrote:
> >> Date: Sun, 19 Mar 2023 18:50:51 +0100
> >>
> >> The label “fail” was used to jump to another pointer check despite of
> >> the detail in the implementation of the function “iforce_usb_probe”
> >> that it was determined already that a corresponding variable contained
> >> still a null pointer.
> >>
> >> 1. Use more appropriate labels instead.
> >>
> >> 2. Reorder jump targets at the end.
> >>
> >> 3. Delete a redundant check.
> >>
> >>
> >> This issue was detected by using the Coccinelle software.
> > 
> > I am sorry, but I do not understand what the actual issue is. The fact
> > that come Coccinelle script complains is not enough to change the code.
> > 
> 
> Right. There is no issue with the code, for usb_free_urb(NULL) is a no-op.
> Proposing as a cleanup, without Fixes: tags, could be possible though.

Yes, that would be acceptable.

Thanks.

-- 
Dmitry
