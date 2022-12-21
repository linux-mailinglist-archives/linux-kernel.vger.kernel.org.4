Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE50B65305C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 12:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbiLULq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 06:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLULq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 06:46:58 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FC11D676
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 03:46:56 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id r26so21588492edc.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 03:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=gGNwLewvjDvWCmEYlH2ZSRpDj9FQim8VgvMWqEwRWmpQKkpfMK0CwUXH/yK2SQwVjF
         7zhxWU7CBFIm1b/ZrfWbDoc51x1xgk+3hy3X1eSHbDX/+tiWrvLq3Y8O7Y9YRxpPPL3s
         ijVn37XGZVcuElYjvrA+iHdLrxZaKBI0kBR5eicpC4jsuTlhM2V25Vn2tHdIJ2ZGrbx1
         eS5/ea0/AGLX+1KwVzOEsQmUQvQRIuCkTONtNcM1RTtMD+VMj7X/c78rS1TDTnB0XFZH
         fuIKfw6NsB+Qbq3bxk9THXGoGPoZn/Eon1+M0kTrFHaLbw6OqjuglXvwR2xzLBaN+Z8J
         hGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=k5Kr5yZy4yJLUEC8CC4hAWtcFDJL6ubaeTzXo7FMwaJCq3vMHA04xdOFpG4CymNPVy
         8+jr8MJuhQRO+UwGntQUEMU9hw+fKWP1nf1fR9rqBZ4MYJjQMZChC+UVHa78Wp0S+bfz
         KyGSweHcN61axOd8UWvY4dN63LsnNdbHMX+UFZ0pxlmj4GiQBMe1avRjtbgDMmII6rLv
         ZO/Zq1XsUWt5f4Y+ObaUg4AKNzl69qOZtW9MLkyAQaNkVn8S2AYMPCmvporvQMhWCKRp
         TpNIOOClUXkxVdphnkR4zzz4n+g9ryfl1QdF6Y6P72a2jJFtskDcI25eLdnyenTs/6WI
         uhRA==
X-Gm-Message-State: AFqh2kp1IJ5Qrj1NcHqQ4gaLI2anhHkTJq0TjjZmQLCKzJIkMvBNj8Pi
        LuHsd6fezl7AZhOw95SjRffDW2aDxnu6hPPiHcg=
X-Google-Smtp-Source: AMrXdXsx0I5vRS3j6uFzysRoE00Bykkjh9TviJ5tHEaSipRxgwxT6WYRt30sWDarqiUM7iO0Dsuett+wew7kkM7ZomE=
X-Received: by 2002:a05:6402:5d2:b0:458:cd82:91a with SMTP id
 n18-20020a05640205d200b00458cd82091amr129111edx.15.1671623215223; Wed, 21 Dec
 2022 03:46:55 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6f02:8390:b0:27:ab24:d607 with HTTP; Wed, 21 Dec 2022
 03:46:54 -0800 (PST)
Reply-To: subik7633@gmail.com
From:   Susan Bikram <ce078822@gmail.com>
Date:   Wed, 21 Dec 2022 03:46:54 -0800
Message-ID: <CAB_XEFZ3LfsQcmkurVAg3VEHC7Rf1-Mpw9N+oMQyeSN-7fJZog@mail.gmail.com>
Subject: Please can i have your attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear ,

Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.
Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Susan
