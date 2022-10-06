Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33425F637C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiJFJUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJFJUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:20:00 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF552B1F0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:19:59 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a26so3201017ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 02:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=Ez/k/AIpa2KdmuTb8haI+g++JCRMevofznrdwaXW6iw=;
        b=KgWldkurZIFTbxqOJjDQap4PX51OMDYWSO2Xo274rnWnodrik3PaZl5imaonfDJQpe
         tQtYSTTU2PXpKDZb0I8haT383LUJbbPXxF8r6VS/J03dZ61iWZXGJjsuauFasRLi3u07
         rCnoGWPQPHQf/AhFo3DVa8+N1h74W/xArAHDj7hUl0K59wsr6oIuO23ap9X9OxWHfoIH
         W6OSx2PJyST2Z3dvDvcwa5dUcMFYsAX2VfXOBer1jBmcN2sFVU/NmfRrDggG2AJJScOO
         /eAaalc7KNMhg0vDp+8UypQd0/pz/kDyyQbCgVb3bNZFyKq3DBuu5aREwdCz7yoCr2UU
         cdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=Ez/k/AIpa2KdmuTb8haI+g++JCRMevofznrdwaXW6iw=;
        b=eXKMfmoR6J7XpkQNw6A5SsXasJNF4kOHlEMdGAQLquU+xrL8BUM+eQZypvYCRqBBFn
         nexwvwtjjLkDW+EGsv9jHawU4Ta+GzgENGbw4wznl3pdjK5oxSiAX/Eq6trD1RaNxz4d
         4dMIumRaZxwRLMvgwCB2c1KV5TR/pJkeM497n0fZgNf8GENmkspIArOl34VTH9nXoJxV
         0Y4HujxVP0fnhqOisLzschtWMSaJgrKF7/YWIdSCZpNh7XmhLpQd3zJT0SaJE+5bEChx
         fvIuY3zbPC23IEoKUoWDNROhek571JJtlcZTfoyp4FClIjf3UuUT+BPZWFTSAutz6kL0
         Po4Q==
X-Gm-Message-State: ACrzQf2YR9O0pKdRjmXMjkZ480ot3Lu2T+ZX73DbWiloEc+xBRq8T+iA
        WqALtEhGwQZ2M1XL0LcvNP8DymixRbUlTAXHIRt6fPXq
X-Google-Smtp-Source: AMsMyM76XYHd8Aqin6FTB5odv/CoJofYabX2XZtVMTtB8J3HFAPhGMjd1eW90XLbN3k4+ne0TkkeK38aZ7TVaIeL3jU=
X-Received: by 2002:a17:907:d07:b0:72e:ec79:ad0f with SMTP id
 gn7-20020a1709070d0700b0072eec79ad0fmr3346038ejc.296.1665047998215; Thu, 06
 Oct 2022 02:19:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:5a44:b0:78d:3a4e:87d2 with HTTP; Thu, 6 Oct 2022
 02:19:57 -0700 (PDT)
From:   lesliietay114 <lesliietay114@gmail.com>
Date:   Thu, 6 Oct 2022 09:19:57 +0000
Message-ID: <CACTx_w7P4GhHUk6TBgKhNeCxM5pV2heHiUULa-u4xD=fB_YFEA@mail.gmail.com>
Subject: Hello
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello Greetings. It is my pleasure meeting you,

My names are Cpl. Leslie Taylor, I am 28 years, single, never married
before, I am a USA military officer currently,

I will like to get acquainted with you, but before then,you have to
understand the content of this letter as a vivid secret for my
security because i am still serving under the Government.
get to me for more details
thanks
 Cpl. Leslie Taylor
