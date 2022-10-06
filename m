Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63785F6172
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 09:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiJFHM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 03:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiJFHMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 03:12:52 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73DB8D0FC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 00:12:44 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id r14so1403189lfm.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 00:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fq/FMo3N2YZ5gAL5l22vJq0j+A2OZhZuCvLwNurrkgc=;
        b=BeaKgJmK52bewHD2XnZ1rIC9fHWAkHU9ZwFN8fcx9GF7mnIPeZqt2kTMkqSWH9Hb4I
         hYT8FcXtUFqr+vV8gADMmONZ/6fMIsQFJonHW2Ccg9JwEWlfx/UPsoGBRYGT/J6mNcXk
         uRP+zItmX+iDy6V9ttTnEEdMYPwKNUf5lZTEFoDcgCFzvloFSlPeZ0PlZ+pLa1/uaa23
         lFaSFOJJx1CZTzA8JO2vnRtjsH63x5zjwgh3aTgmdPC0EX+k6XBFCR5lXCLuopDP/2Qx
         m/QFl2W1AGsypYrKrGf6caAGB7JPJ6vGmUNi5V6oHFGQ+L+HhsC/VNJRWHEMEZN0Cw4F
         A82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fq/FMo3N2YZ5gAL5l22vJq0j+A2OZhZuCvLwNurrkgc=;
        b=BchPqRg4IrWFmAOm89nKEPIVeWmGOaq08mudOtVkWx2QDFMnOUBSHqH/PHtfdHY9vF
         LqCT/kGIs5ftVLqe2H8RM6CwYJkQhVoLGWiOyZ4kEHs9MW4/kPZ7dtIKT/TpTTmUEQ0w
         vPQNgwmLuUJz30GibPdCJNfDOryUh+jVNcGmzZEt3DxtBQUGDdHctOAdINyVla5VEVkM
         +wH7d8hWWyLQI7mHkXQ3iKzoBkJVrJShtFFCpLLlTPsNeRS7ezftfy9R+q+25ONOdsAY
         hXM/MIwb9XW9V82ldDN5TYbtWT8iDW05k1oe/9Z7YclSJ2bI6hqReaKd7Dj/SShUD1cs
         oAZg==
X-Gm-Message-State: ACrzQf1qmyukKrPkAMqWrtgR18DkkOe4r5kfDuhgpmGpqpX/YdCU4yPk
        P4jc/CPjEEaiE9+d2kKEn7J0ioddlCn+kz/ryZs=
X-Google-Smtp-Source: AMsMyM5ggKJDaJ+6eHm4nSHGcJvUvK2zxZR9zM1zNLsV5ZHP7nWkBszWtv0q/HxU2ZLQ4ETePmYL6MdhaQxqlpk1TXs=
X-Received: by 2002:a05:6512:3f14:b0:47d:e011:f19b with SMTP id
 y20-20020a0565123f1400b0047de011f19bmr1204050lfa.427.1665040362350; Thu, 06
 Oct 2022 00:12:42 -0700 (PDT)
MIME-Version: 1.0
Sender: nnnnnnbmmmmm@gmail.com
Received: by 2002:ab2:32cc:0:b0:164:21ae:707c with HTTP; Thu, 6 Oct 2022
 00:12:41 -0700 (PDT)
From:   "Mrs.Yu  Ging" <yuging9567@gmail.com>
Date:   Thu, 6 Oct 2022 07:12:41 +0000
X-Google-Sender-Auth: PvEkQDdFlkc8jWxveb6-9iDZHLw
Message-ID: <CANXmihG08VBXcrjj5kwHh_9xS-P-KMiLG-ik30fXe8zCb88t9w@mail.gmail.com>
Subject: Hello!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello
I am Mrs Yu. Ging Yunnan, and i have Covid-19 and the doctor said I
will not survive it because all vaccines has been given to me but to
no avian, am a China

woman but I base here in France because am married here and I have no
child for my late husband and now am a widow.

My reason of communicating you is that i have $9.2million USD which
was deposited in BNP Paribas Bank here in France by my late husband
which am the next of

kin to and I want you to stand as the beneficiary for the claim now
that am about to end my race according to my doctor.

I will want you to use the fund to build an orphanage home in my name
there in your country, please kindly reply to this message urgently if
willing to handle this project.

Mrs Yu. Ging Yunnan.
