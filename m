Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F72560C23A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 05:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiJYDX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 23:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiJYDXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 23:23:51 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC5B4C2E6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 20:23:49 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id io19so5173588plb.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 20:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f9FEmbC5xpjHJg/2O8DNlMMB4H4G84Faq1RNdC5/70Y=;
        b=J6AoKAQCxSkBd/sowbwPCi6ub1mPxV0qlHWX0WF7X3NIlYQn4YHES82Srn6p4epgIr
         I/r34Cbt1RAn8twGDRZkfGNfzOPw/CE/lQ3d8KKm/xk0O0byOMZgfEBxXin8xMsH6Ae4
         OYdMDc09gEwKmklQ38eKDQ1EP/Ifp9975kI3vOWpMT2+B7APWMDg1HWdHh6RDm2IhmZp
         nFlQWBQ5LXCjatGUOm0Nssz0irDhTOK5bRfoLWDBGVjr3x7Zn+3TjCCDg34vvNahoMXf
         /GTBMcEoPm5pkxKRsBe/cZklokeE7OuhvhWmNxe9o2BV3Dg9u2aHkD+tP04uQVNOH6VR
         XDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f9FEmbC5xpjHJg/2O8DNlMMB4H4G84Faq1RNdC5/70Y=;
        b=VIICYBxkDL9xsOpDHIYm30SwNqKRUndvTHHyqdSftWQ2EV+2DHL73H2KtvIlIyS/pK
         0exfwkQUAuXfBc4M0uy3Ytvt6BIITb2jCoa0iSjOA2/vKYRvs8SL8uBqKycKm37Mv89c
         O3boAzf0qWpbRPcHWecLccILFonzqXlpsRB7InGem9lszgysu5gAI+5iDtpVatW16zM8
         EZhtQH2uq3e6sQVeseWFg0emhn5vp9PHaAEIBfo5JTUhkIWjyO/v6K7kVA9L38Vs+8u3
         iKKdOPtcr/wKgDIFZFxNnv+ZecT5L1go+pjLSz6LCOF7IIPfUyC/MQVsDJHABe3HMgc+
         LnmA==
X-Gm-Message-State: ACrzQf3A3peCDLEBaGpsZ1SQT/P0HZfOGQtio/UgQoJLEYjvPx9VixYN
        /3QMGW8d+TWZ8AXTWZJ+Idf5xw==
X-Google-Smtp-Source: AMsMyM6T9pbgn5kWI4AmOtmghV7rd1u8oseHmlwr+2DnuT3VwNTxi88zyEHreGyjv+o07wkD42j/iQ==
X-Received: by 2002:a17:90b:4a47:b0:212:f7ef:1bd6 with SMTP id lb7-20020a17090b4a4700b00212f7ef1bd6mr13717346pjb.79.1666668229127;
        Mon, 24 Oct 2022 20:23:49 -0700 (PDT)
Received: from ?IPV6:2400:4050:c360:8200:8ae8:3c4:c0da:7419? ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id n16-20020a170903111000b001868d4600b8sm397270plh.158.2022.10.24.20.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 20:23:48 -0700 (PDT)
Message-ID: <8ed65e3e-e0b9-05ae-b113-db9d649a1e5a@daynix.com>
Date:   Tue, 25 Oct 2022 12:23:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 00/22] Fallback to native backlight
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Mark Gross <markgross@kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Cezary Jackiewicz <cezary.jackiewicz@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Jonathan Woithe <jwoithe@just42.net>,
        Ike Panhc <ike.pan@canonical.com>,
        Daniel Dadap <ddadap@nvidia.com>,
        Kenneth Chan <kenneth.t.chan@gmail.com>,
        Mattia Dongili <malattia@linux.it>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Azael Avalos <coproscefalo@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Robert Moore <robert.moore@intel.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net,
        ibm-acpi-devel@lists.sourceforge.net, linux-fbdev@vger.kernel.org,
        devel@acpica.org
References: <20221024113513.5205-1-akihiko.odaki@daynix.com>
 <746e5cc6-516f-8f69-9d4b-8fe237de8fd6@redhat.com>
 <edec5950-cec8-b647-ccb1-ba48f9b3bbb0@daynix.com>
 <60672af8-05d2-113c-12b9-d635608be0dd@redhat.com>
 <ea69242c-0bc8-c7bb-9602-c7489bb69684@daynix.com>
 <7373e258-f7cc-4416-9b1c-c8c9dab59ada@daynix.com>
 <ae3497ed-b68d-c36a-6b6f-f7b9771d9238@redhat.com>
 <78ad5d7b-4078-0b8e-f4aa-6c8113631359@daynix.com> <87o7u1drcz.fsf@intel.com>
Content-Language: en-US
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87o7u1drcz.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/25 3:11, Jani Nikula wrote:
> On Tue, 25 Oct 2022, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>> That aside, the first patch in this series can be applied without the
>> later patches so you may have a look at it. It's fine if you don't merge
>> it though since it does not fix really a pragmatic bug as its message says.
> 
> I think it's problematic because it needlessly ties i915 backlight
> operation to existence of backlight devices that may not be related to
> Intel GPU at all. The direction should be multiple supported backlight
> devices, across GPUs and connectors, but only one per display.
> 
> BR,
> Jani.
> 
> 

Unfortunately it is the current situation (even without this patch), and 
this patch is not meant to fix the particular issue.

This patch replaces the following expression:
acpi_video_get_backlight_type() == acpi_backlight_native

As you can see, acpi_video_get_backlight_type() doesn't take a parameter 
which represents the backlight currently being operated. The problem is 
known and documented in "Brightness handling on devices with multiple 
internal panels" section of Documentation/gpu/todo.rst.

The exiting solution is based on the assumption that no device with i915 
and multiple internal backlights.

Regards,
Akihiko Odaki
