Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FF563C649
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 18:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236542AbiK2RRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 12:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236396AbiK2RRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 12:17:53 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21B41D323
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:17:51 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id bx10so11117515wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZKN9Q+eq0uc2V72eeYpmTHIZGYsEOhCOCy20hkaLTtc=;
        b=TOnYs1ecs7ME6pLERhlGGIwNLRLNc5HzSwU1yMLg31p5hI+YtZrFqz5J7fDroQsrvT
         +N0DGMtT+sJu9pV+t8DBDOZw5R7v1ruMbqI0lG9K0DhF+4IeTzKfGSy3dqxWWxwW0+gJ
         LSCMhbVm9woQ+M0lShcVR1z7jvZyZeX7rcmpjYk9kACBBKj6dasIL6ICbUUtdkLkmlRA
         5TCS1NumrfbQFwyeNPbWp4m3jXaEOAh19q3P/MV/09ocPsC4xvw+1+2/qHbT+xjLdon/
         YLJnJL10aYs2nudxaC1VOyqUMp/WM8DHNNMwKLJIs1xMTdREcVi06yx3W1sd9O7tQrY9
         +MXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKN9Q+eq0uc2V72eeYpmTHIZGYsEOhCOCy20hkaLTtc=;
        b=qw7uINYIAgwe3Mz1vQL1OFe5h9y68iSZX1L/8RfeEbHySJQyPIZ0alcCKj0rBAyojC
         MfLRTLbSkmmmnLzaqm5rcQrShGvV1cmMZhAMkWl4jwSiFpU5jAroZsht4UFy48M2Zw0h
         C69Tb/cvoBk8oX88xuVska7f9+1qPFC+gH1x2G0aWfu1fCUGFmQ+PnkA7SZX2XW3GPHq
         Ge7hBAAQeaUqV3/0rR5KXtl06TgHc0cD6KwErbwEi+g5ZN6MKtgGH5RP5wo0fiyrq1pL
         5/SaUUEikSI1uBGy7TQTmJxvUqFE01MZmye++Iz5Laa4urplzegTG2X5gCb0M1s5Lh1T
         48Lg==
X-Gm-Message-State: ANoB5plYifkqbR2VYfwSAbHgbYZv0pxHWaIogFZEiTZIX3bkS2mSHopG
        TQ5vf33oqdto1QbbISJmZUFwJEihjrvaL0Yeu6U=
X-Google-Smtp-Source: AA0mqf6vBo5wiObH76uTvIylbPUCl9CVgT10F6x+9KcRy+P0gXOk1DRqm8BRxuKJZ0GcGscr8rmLgA9gh1e034d2+Po=
X-Received: by 2002:a5d:6243:0:b0:236:6b05:a8be with SMTP id
 m3-20020a5d6243000000b002366b05a8bemr34343493wrv.346.1669742270339; Tue, 29
 Nov 2022 09:17:50 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:600c:384c:0:0:0:0 with HTTP; Tue, 29 Nov 2022 09:17:49
 -0800 (PST)
Reply-To: thajxoa@gmail.com
From:   Thaj Xoa <banglebea@gmail.com>
Date:   Tue, 29 Nov 2022 17:17:49 +0000
Message-ID: <CADTJrWO1Fw6rJ-CaE7GsX7uDzdXvagZ1ds+x3cGtz8uW04SRJg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Dear Friend,

I have an important message for you.

Sincerely,

Mrs thaj xoa
