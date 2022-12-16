Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D870C64ED8F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiLPPJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbiLPPIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:08:25 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AD26034A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:08:24 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id y16so2814678wrm.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwuIivs2bXND3SDhAV+zSYDmApbibgZQPxXCRZ6VkeU=;
        b=SFuW8qj6iWcdEQ50Hah4/TOmKX7Hpm6TRyGjVMqt2fPMS8njz4TM6WVoBvzQ9795Q3
         4dH7kngPeKI4mFk9qV2rnIgfWPyknPfl04bxVtuAuavouiFvGJs2FfIVMA29DQuOi2sp
         qYUBSFcQ72aEcKpn9DnrjmQQoFSgX3wtTwtGiCad0StEL6X9cxl7QMMm5oLR3SGoyw6D
         5ZoNiWhS9W/1F2tT0L1IzN8HnK5KuJYat1KxeNZTeAmt8y8mmYyRFlqeF6eLbjtRiaca
         Ndt7sF1v6x384oFVZfsRrHd+W+o5cgluCURKPtpaTAS7EjOtppZ6u4T/og2yPo+RosNI
         vrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mwuIivs2bXND3SDhAV+zSYDmApbibgZQPxXCRZ6VkeU=;
        b=vTEzMzpLVavYo3ljNr4EhaaYd59udUbpka14BBOwdaTyr+217UoPUGHTeHTffRgTDS
         pZodAAZ258+92sCyilTFD9DItqhphYvcSHOMOuirxkgrpGr6dknc9kpLt+eCv/avCMU3
         pqTdJhld2FGW9VK51shMfsvG2eFk2Fss8KinoajkcPg+g7LU27L563Y6i2UkgrgP0P8+
         uLjR6q2wfJmMoxObEAkeWYe9qzgql1gWTBMvKxbobmCfTaCb/+OTCytL3nEk8Q7CfuHc
         WvFPSrPi+R2MvUl4F7/GCNvUBUw4oYrboB1kuI5JhYHVTxV7wS+1SBSV7pXoh2J9Y3Y9
         6e4w==
X-Gm-Message-State: ANoB5pkCJiX6biD+Zrl3y5dgMPnh2T9LKa+29+lKJPwPmTv9xBZF9jQY
        ze50vaQnoMZ6rl4cpGUg8eP8cohdBlb/G+FR4tc=
X-Google-Smtp-Source: AA0mqf6ME68eZqLdGq527og3+Z+l69M42RRC0AXTpfhcfHJ2MmZ5CVgOPxU4euSsJgPyRHMq+dnuCgDzA0yt8Utndgw=
X-Received: by 2002:a5d:500c:0:b0:242:1991:f68f with SMTP id
 e12-20020a5d500c000000b002421991f68fmr27744733wrt.265.1671203303130; Fri, 16
 Dec 2022 07:08:23 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6020:a406:b0:22b:10c2:d840 with HTTP; Fri, 16 Dec 2022
 07:08:22 -0800 (PST)
Reply-To: canyeu298@gmail.com
From:   Can yeu <philipshoma@gmail.com>
Date:   Fri, 16 Dec 2022 16:08:22 +0100
Message-ID: <CAENVCOSt3JG7K6dyQLcYfo5NQFHxUyishVz2AWpNACaKR0s8rA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Dear Friend,

I have an important message which i want to discuss with you.

Your Faithfully

Mrs Can Yeu
