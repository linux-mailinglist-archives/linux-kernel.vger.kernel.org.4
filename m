Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A97A5B8105
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 07:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiINFeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 01:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiINFeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 01:34:09 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1173B6D572
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 22:34:08 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id gh9so32171311ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 22:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date;
        bh=+cXCliPahVf8vqxvGlfehOFUjgK+fXTy4kqPiy1IfcU=;
        b=puRc+v7Rm3M5MmX+s/NdDw9QQ+jOFIfvAzW3JFmNnfuBtfHinvXrENcy4MNUrn2Dtz
         Xy6mxm3yDRBMD6xKj+6tilJMvaHUiTbk+op5+mrODO3ORAPaA9MHd2z9ndYA3vmDuhoJ
         fY4AO0SJlUuamrKFxyEutWIoavQ9gLGfnNZfxKiNzenEp9fQDVB0NMofHIAfzzCbeavo
         OOSrSPNJAsc6Y2lnLFw3cQlBj28uHPHc+KcfnIY/oz4os/G6SlZCbPE3lJqFmJmP3j11
         nL8pNepKf9ET9qQv/QLULTamwyh0m7UbtNr65S9wo5vqstnGmMxsNXZzyiDxlAEUqdkc
         zdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+cXCliPahVf8vqxvGlfehOFUjgK+fXTy4kqPiy1IfcU=;
        b=731knUQmOBebEpVBPHnS0WVdn1m0a2v/2gUpqfLoy2ccKx1QCCtUqGDAueNudy3G2k
         E0gY8iSordaR2/+bIybdJ/BJyZSksrRj3UsNND+V22kV7wahZcQbJyRnGtwcWt3Chie5
         rW/vvB5kwS6fBg0zV87HXHXn6Gw08TwWmeW9cfQeaNbKwXm3imPWms9CSG1fAl068RRL
         HbhgXw3xBuss4hPIm1FP/do5oBTooqlNi5JDXF1Jw0ldvE6nCuoFfBN8zoPK2NQRFvtX
         ReweI2jYs1IRhkRMhR1D17MyFdlRwhaGTm1SwkhTtUGebO0yKtTZ8PtXo7KuMJd02chr
         Ar6w==
X-Gm-Message-State: ACgBeo2aB6l8468m7S33emTMD2tM3cSqsnCzEho9wFAGo4rQ3F1GveVj
        r+/v/yKFS7ioZaor6vg2ebzF51eF0pH3Q2Qzqfw=
X-Google-Smtp-Source: AA6agR7ysOZR43Gw3/wbuVCenAnSjdOi5+LvPg+KWnLlQ7vZZvDOwAWjg1CSYkI7eoP7VlQh+dSGyJW/9oXuNdv4KJ4=
X-Received: by 2002:a17:907:728d:b0:77e:143b:a86 with SMTP id
 dt13-20020a170907728d00b0077e143b0a86mr7983648ejc.770.1663133646669; Tue, 13
 Sep 2022 22:34:06 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mrsninadosso@hotmail.com
Sender: petbarr13@gmail.com
Received: by 2002:ab4:92ce:0:0:0:0:0 with HTTP; Tue, 13 Sep 2022 22:34:06
 -0700 (PDT)
From:   Nina Dosso <dossomrsnina@gmail.com>
Date:   Wed, 14 Sep 2022 07:34:06 +0200
X-Google-Sender-Auth: lbd7uo9wmasHFJHBvXZxtNN0uok
Message-ID: <CAOV4nDwZBsVV_7wb1sQ2fdk83L7+LkZGxqDtNa5n=gQAT5Ug+A@mail.gmail.com>
Subject: Mrs Nina Dosso
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 

I am Mrs. Nina Dosso. I want to carry out a charity project in your
country. I had wanted to do the work myself but my bad health
condition cannot permit me to do so. That is why I am contacting you
to see if you will be interested. Get back to me if you are
interested, please for us to proceed.
