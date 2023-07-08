Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034FF74BC54
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 08:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjGHGBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 02:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGHGBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 02:01:48 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72CD1FE0
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 23:01:46 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fb7769f15aso4254362e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 23:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688796105; x=1691388105;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eRT5n4rQvoKM/ql/HZkss7VHi343B6VAigs6z33nLZo=;
        b=d83+wxFxSEvgopqfKrE7GVZUrJJrRaccIaMV8vxeSEaMUb8os94Kmop113jWrVvmg3
         Z0Avcc+4T3uq12EZ1XrUV9XJEfyK3+wkPR9vb8sAUUZBY0wgtWuit9nrKvyx9Kz0lG3j
         gyWHdMPC4baqQuAvjhS4pKmPOjQN+QXTFf9GX9PgC118RY55BhyePSvnAQHFP1yo9+wZ
         Tnps4+9UwXagIZDPgM+gg2IeNWju2IVxrpYabiItJxxgAdVROJSVcuKHw5pV1enrwrU1
         7JBazutXSF9gKPKpMkf6uQIYcWlQ8FeOI/4JUnge4cmFCcUt1pZGUQtkXsSYeRCJPdHU
         IjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688796105; x=1691388105;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eRT5n4rQvoKM/ql/HZkss7VHi343B6VAigs6z33nLZo=;
        b=fTNPW+Rfc1+iQNGMYnL5tpYIZkyIQ6j5xQeZwn97K3TeJOkqIidcYdpd1IlvAqL9SY
         38CnxgIjy0GqoCnSX8svctlnHzh0Qh0m/4dFNyhb7R111EkMWbiWPDfaObgRXZJNcg+r
         5T2ABWva2Uk0LgaVjzkFHepec7ch/P4GK2OwJB66xA1LmYjopsp4geSQwP/creVRxySN
         nCk89PW1UgkvhGT3dsmAijfZgm92ViUvYFJcgUA83Tx13uUD7jbd+/11NpxsMzHCMifM
         rDL1pEFaIO+fGv9LawAJ8Su4sUwRTO/5rb3ZuuzXcTzS34AZ0FSQ0kGM+oyorFJKQgm9
         BYwA==
X-Gm-Message-State: ABy/qLa/6n8GpPcoj5mvY+FB0U1BqKni1iM216QiEPJ/KgJxVhUejnvH
        rdBmGhlIRRYBu157SPA/f2pbQLHILCs=
X-Google-Smtp-Source: APBJJlGeaI5T3bGBhbEy9o9l3p0Rbf936fn9LOvLNWcxQvnXTU18Zxeb47C4hFRV0zGDfBEquVJGUA==
X-Received: by 2002:a05:6512:2392:b0:4fb:763c:af54 with SMTP id c18-20020a056512239200b004fb763caf54mr6748408lfv.62.1688796104686;
        Fri, 07 Jul 2023 23:01:44 -0700 (PDT)
Received: from [93.173.115.83] (93-173-115-83.bb.netvision.net.il. [93.173.115.83])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600c378600b003fbb9339b29sm4220795wmr.42.2023.07.07.23.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 23:01:44 -0700 (PDT)
Message-ID: <b2f05f50-7084-48e2-6ec5-b70c89bbf5f6@gmail.com>
Date:   Sat, 8 Jul 2023 09:00:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/8] char: xillybus: make XILLYBUS_OF depend on HAS_IOMEM
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org
References: <20230707135852.24292-1-bhe@redhat.com>
 <20230707135852.24292-3-bhe@redhat.com>
From:   Eli Billauer <eli.billauer@gmail.com>
In-Reply-To: <20230707135852.24292-3-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I stand corrected. Thank you.

   Eli

Acked-by: Eli Billauer <eli.billauer@gmail.com>
