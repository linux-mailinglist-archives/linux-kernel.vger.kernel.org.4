Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BB86526C4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 20:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbiLTTIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 14:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbiLTTID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 14:08:03 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FF92AC9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:08:03 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id m14so12705002wrh.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=A+aO5+uSh0O7dpkxd56ACzLt18XNTvXLc6UxjycHhF6o82VqMhnPqmKQeMB/w60n7w
         mxjcO3FEOPq4+/cU9SGkalCcCqnO6zBQww+25D+3fQCOKm1+CvvRi+/yJpm40njecEtO
         mjyW07AEIt1wH/1UJonfD+StjDAoeVFlkLhlJenCqtRU8CT7UYLG1mkaM5BrFrt532uQ
         aCu4/Yrsr2COotCV7+QZQif/q7ygGs8LBd8lYlYOlDEgNBnCnu+7svr3ofi/t9iaEGy8
         dvBs8XRbH9aq5YRbnk7+zq1A+sWHS/Z7ESHX1b9+TDAa64m8bu7A9qaQ0P8daoeM8mzQ
         lzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=PYNJWHMyNJ2ygAfMLJ4Srz4ufEodXSW6H/40ugxr/jfOL4/3DgvnwnlKFY9408cQbo
         Rh1pRuThr+7mu+TrgrDm+SHFx/PWuQ7Scm9Qqf0nzBrr/3FpNoZpZ+q8rOAEVgO9uOD9
         oikqj1M/fEIRChYo2Qqavwuctqgssd96v9EfDz4yE8zBguqhfPmDWdhBRlERuS8WPfe7
         rI6zbUrvujgL++C7XXkigTFaPBihyR9JByF98Vaqaz2LqBuWUfJOGAAOJeXONjjyylU+
         PlKIAtsscHaWJ2v4F0eUlurp1ppGeLnrafwRhUiS2FupcoDvEEUfQytK+lLEq8FwI93q
         5D0Q==
X-Gm-Message-State: ANoB5pmC0xhEwMBnFiFJRA/ySNsh0qFjuIvdCV29AaXLPdSM0fRZURTH
        mO/UbKlmcB4dRQnjKIMx6aOCvVMQkSWQcs2ujFU=
X-Google-Smtp-Source: AA0mqf6QEditEKCwq3gTGUksuPgxN/lvtVZLybeXeQQt64QqV8iwAoTl2DGu9MVLCMhGQPAJo3C+a0PULOX0qJhWk2k=
X-Received: by 2002:a05:6000:787:b0:24e:ca7b:abcf with SMTP id
 bu7-20020a056000078700b0024eca7babcfmr1239070wrb.638.1671563281525; Tue, 20
 Dec 2022 11:08:01 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:adf:e30c:0:0:0:0:0 with HTTP; Tue, 20 Dec 2022 11:08:00
 -0800 (PST)
Reply-To: ava014708@gmail.com
From:   Dr Ava Smith <avavaava9090@gmail.com>
Date:   Tue, 20 Dec 2022 11:08:00 -0800
Message-ID: <CAL0WiVU14P1OW5PckPZ5S0aMXF_tU=Z3RUFa1JQh=T3q=-ELoQ@mail.gmail.com>
Subject: Hi
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

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
