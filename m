Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BBB678636
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjAWTWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjAWTWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:22:38 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E86532533;
        Mon, 23 Jan 2023 11:22:36 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id m3-20020a17090a414300b00229ef93c5b0so11234964pjg.2;
        Mon, 23 Jan 2023 11:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jeEeVm9LX0/txmY+SjoLpXXM852MP4FDTc4b+FdlS60=;
        b=B+kgLy10f7DyOENfJpCRRh6artYhnRzNIKSEzIFFu+N2jgmmLLdGdpUhF+Vj2WOc5b
         4dbfzwfF2R9jXSSKtkW/Zzqw02+Enzu2J80WpajJ1ZDIl1Iy0P4ItRg4l3HfROmC+dUd
         kKVlUzoJav/yQ+PMHsXb3aGJ/xNeLA4iaHvPk1rZPMiUuCxHAQU6NVpXGb07vhFQoSx5
         vcHcuQ0HScKvOxfu1Owa5JGnqZEJGCF+PyamKEoI0A33IOACvf7D/FAslpoC/X+8oBjO
         Xzmr6++MtYkkIuQSnHnp2jEMExdoiAdrTIY9ZZnpihC1pRvIv2sxZilqnAlSZP2cfIsZ
         ukHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jeEeVm9LX0/txmY+SjoLpXXM852MP4FDTc4b+FdlS60=;
        b=wGyLEmV9bL62N38azeLUuet1h0/KqXREIKCxRqq3r8+0kVEHVUQHATZoE+xl2AUF41
         P2QE5Uc5zJ7UctgG06NBj+6LmwueyAESnfo0mZB4yrriq9p06/pW3qr5LfnK87BhTGzf
         dSNj8yP3ow9rRwH0GArJ1M33O4/TfBN5yF/JxSURMuBYbbPGzOUKi0K28TSjPPMDlYbx
         BRz56BIBlBd1OUt27bsbUp3hVje6qlqWGyscqbHbMa+KgOhYHGHVwjD1tp1bnYB/1vL3
         JC3Fw5kAg1EukiKhLSUz/a20AIIblhPNGCYiOYVrNyUKI4K/9NKm5lnc9HQ6zoNr98MH
         kaRA==
X-Gm-Message-State: AFqh2kqA5Pyarn7X/KMdL1d8VzRIWZ/ZwyEyWOBY0eSmEwXxeQQFRhID
        mvQn03J0heYUgdLWEhEvFyQ=
X-Google-Smtp-Source: AMrXdXsa9k7v4xYA8Vyc6tZZJ65obCidCp3gNQyOnyLHeJip2+RiLOLOLjc3D4LwiXjD7eN6GaMBlg==
X-Received: by 2002:a17:902:ef86:b0:194:59c2:a154 with SMTP id iz6-20020a170902ef8600b0019459c2a154mr25439711plb.61.1674501755848;
        Mon, 23 Jan 2023 11:22:35 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id p4-20020a170902bd0400b0017f756563bcsm75200pls.47.2023.01.23.11.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 11:22:35 -0800 (PST)
Message-ID: <cc6e1a1a-2f5b-4ba6-f728-efb8907754a8@gmail.com>
Date:   Mon, 23 Jan 2023 11:22:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 6/6] rtc: brcmstb-waketimer: allow use as non-wake alarm
Content-Language: en-US
To:     Doug Berger <opendmb@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230120190147.718976-1-opendmb@gmail.com>
 <20230120190147.718976-7-opendmb@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230120190147.718976-7-opendmb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/23 11:01, Doug Berger wrote:
> The wake interrupt only fires when the system is in a suspend
> state. Fortunately we have another interrupt that fires in a
> non-suspend state at the L2 controller UPG_AUX_AON. Add support
> for this interrupt line so we can use the alarm in a non-wake
> context.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

