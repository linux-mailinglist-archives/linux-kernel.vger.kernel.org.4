Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762BA6740C5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 19:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjASSVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 13:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjASSVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 13:21:36 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E881782D6F;
        Thu, 19 Jan 2023 10:21:34 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id k16so2232809wms.2;
        Thu, 19 Jan 2023 10:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yGqWDYNV/zj4CViB/rzlzxmbjJcNm5WbqvSrrqvqKqA=;
        b=WgVoJRGiHYIj0ItSxqG3rKEtsX6JMplwgQC2tynjIBdZDikc0itBbnmglgZoxQxTrK
         J8FskCoDTDzVgCwKWuuVQhpGpb1zkZJ4sMT8FqviHJvkWe1SD9iAAiguEH5AzS1v4Jiw
         H1S8lqRBgpPBCkO4TRhlGdg9xWoW0gDehzaO4iXjdZ+wi4W7kiI1jhuCrWHx/rxZ3Xx1
         p5W8GGVWgcs+uUNk4/9nZyrKa11czvnkP57PXuADpFFiPh6gND2qndPe1j1SW21beZnD
         2eT/GDrgQ+00qJyMC23whBB+3tgNCX72iob5avRKzHHIrIPlzyzz3zUtrlt5AHRVRQli
         KBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yGqWDYNV/zj4CViB/rzlzxmbjJcNm5WbqvSrrqvqKqA=;
        b=18g9ijCVdo1M5mILvHOpZHWlb5h/8r4WchDnK5RzgW8o9vxh94PzzakqgTmPNyGdw5
         nyh7bdTihAT7K4vGwvtZwy6mE+gVMDNpQgxbO7tfnuwwH9aOUqoKwD6Fn8tgH+27c3Cy
         2oUI/nzKlKn9mfhSrknWDijcTNiPkuV/UpFTPkOMGagfS459XaYmCZ479UrK3i0t+HWG
         Q08YzzZE+fUT6ZnywZjLjaHxhJPYeFc9NviNnZYbSt7O+t2d9KUSNg9IAg3ernURtXPl
         Ud5+VrJtc+UzpxpmZD+HJ/uJolQ/m66iFIuvw1N1eKEBL1fFFAdRfvlR7URyWAXgB1t/
         COfg==
X-Gm-Message-State: AFqh2ko/U/uPCWprvxNpXEeXVLhkQBST1N67qGu4YN878n5ih+sizFg/
        zGoY5b6oL2nd/fBu3CFzZ3A=
X-Google-Smtp-Source: AMrXdXsmDmS7q48LKnqE9ktFXgp6/WhmL/HhhbELcw0kvq1rsbIbBxTPAXFGPqF32dmnGf6uBDssig==
X-Received: by 2002:a05:600c:3488:b0:3cf:68f8:790b with SMTP id a8-20020a05600c348800b003cf68f8790bmr7497484wmq.11.1674152493172;
        Thu, 19 Jan 2023 10:21:33 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id q10-20020a05600c46ca00b003d1f3e9df3csm5782098wmo.7.2023.01.19.10.21.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 10:21:32 -0800 (PST)
Message-ID: <6fe3fe94-d2a8-1fed-241f-16999ef22fd3@gmail.com>
Date:   Thu, 19 Jan 2023 19:21:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v7 4/7] dt-bindings: pinctrl: add bindings for Mediatek
 MT8365 SoC
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tglx@linutronix.de, maz@kernel.org, lee@kernel.org,
        chunfeng.yun@mediatek.com, gregkh@linuxfoundation.org,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, nfraprado@collabora.com,
        sean.wang@mediatek.com, zhiyong.tao@mediatek.com
References: <20230101220149.3035048-1-bero@baylibre.com>
 <20230101220149.3035048-5-bero@baylibre.com>
 <CACRpkdY-VqM_mzgJ=n9fEtFJD64EBie1EQF+8Bk5iLE68mCnSA@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <CACRpkdY-VqM_mzgJ=n9fEtFJD64EBie1EQF+8Bk5iLE68mCnSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/01/2023 14:35, Linus Walleij wrote:
> On Sun, Jan 1, 2023 at 11:01 PM Bernhard Rosenkränzer <bero@baylibre.com> wrote:
> 
>> Add devicetree bindings for Mediatek MT8365 pinctrl driver.
>>
>> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
> 
> Looks good to me, do you want me to just apply this one patch to the
> pin control tree?
> 

Yes please.

Regards,
Matthias
