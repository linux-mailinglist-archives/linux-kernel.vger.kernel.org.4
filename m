Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70878739F65
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 13:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjFVLYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 07:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjFVLYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 07:24:53 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDC819A9;
        Thu, 22 Jun 2023 04:24:51 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 3E8D05C00B1;
        Thu, 22 Jun 2023 07:24:51 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 22 Jun 2023 07:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1687433091; x=1687519491; bh=Ao
        g9Wt7TDsOLeFf/oUN+PK0V2D/l+qGT79F3oMaxOv4=; b=wSVxF69bqU+7foITvm
        btLlhWjR4nGZkGsc3YubNmpu6kdZEc4vlBaQIuQtZeKSChwf/7Qi9Eni/DMegslD
        PQaeqGZRKYvTSJpTRzDBqwhdnVKDFOymCB5dzOYLA8xclekO8E3NwOGJYIozeqtK
        CRlMKqGxEHRfFP+t3Lpc4RfwFRGIpkg2bAxbct8kIP2M3NWJ6Lem5JNltXwW5q3H
        3HJ0HfZnZqt4vMo8n34yeNb+Af4CNCq4uyBPcC27vdy69Z2RoZfkbdHmwLJsQSXf
        b2KDIb+MDQUYNQMB7GQtiTDmEwG3tI7cMivz7HSumVT6AyuHTXIqC6QRv+I1gFjE
        euqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687433091; x=1687519491; bh=Aog9Wt7TDsOLe
        Ff/oUN+PK0V2D/l+qGT79F3oMaxOv4=; b=YA6SkFmksYRGHbfAYJrSiQf0cWr2a
        YAOsdd6xggJ+YfCdEHapdGJ2xx6uV8cfxb2CAiJMUcTFeuTLTFLZTPb7u0vXEIR5
        yi771tPQ0+UEHvA5LDCcqyh0jYW51AVALV9UFUP549ISbpa1BLHd3cLg+q0y5mTv
        fRpOlhFlUID987U+LQWCt0b8PHQ5bj7D2P/12hkwMSkIp5zFskShlcgwsON3uPt/
        laWj9RyWM4wck9w4qmy39CpHOHNQdxyquzpaeAPwWu0GpbyLcvTi/+d72sdIiEiz
        dic51y7l6lxlG3QNN3ojSzcLhd25U1UvqeQOzCsQzbTuVT1c5AUhizIiQ==
X-ME-Sender: <xms:gi-UZBNeSMGM9IAbCTI9rGqzHyB_-V57SiJZrVuUnY0MeSEy38EtrA>
    <xme:gi-UZD88z8vlG6H3uMWhORZSIAFR7CIkn1jkhwLbBOxfEEvflzkiihjvY8ozTnQQQ
    EhUAMJCiZm9Nv3koRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeguddgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:gi-UZASZ0RqA86Uv9RsS204GM4F7h1WtExGxmi393x9-SRPmAi1DRg>
    <xmx:gi-UZNsqS4fEdMjTrp8usvMz7ws-1aEUagBGzulzqhJe34N5JZC3kg>
    <xmx:gi-UZJfFqctxCaKkZf4KYGgAvgrA_VuVHPeu-ZqactEESx1IdGjnNw>
    <xmx:gy-UZCGVtDmgM1JuH2eJMieSuhaE5KW2ZLhNoL8JMM88DziWLz2WAQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CA308B60086; Thu, 22 Jun 2023 07:24:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <f28f78fc-84ce-4990-9126-4075f3d88e01@app.fastmail.com>
In-Reply-To: <286cf2d8-2da8-7203-ee53-bf08332fa519@linaro.org>
References: <20230622101813.3453772-1-arnd@kernel.org>
 <286cf2d8-2da8-7203-ee53-bf08332fa519@linaro.org>
Date:   Thu, 22 Jun 2023 13:24:30 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Neil Armstrong" <neil.armstrong@linaro.org>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>
Cc:     "Bjorn Andersson" <andersson@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: nb7vpq904m: add CONFIG_DRM dependency
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023, at 12:39, Neil Armstrong wrote:
> Hi,
>
> On 22/06/2023 12:18, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> This driver calls directly into DRM functions and fails to link if
>> that is disabled:
>> 
>> ld.lld: error: undefined symbol: devm_drm_bridge_add
>> ld.lld: error: undefined symbol: devm_drm_of_get_bridge
>>>>> referenced by nb7vpq904m.c
>>>>>                drivers/usb/typec/mux/nb7vpq904m.o:(nb7vpq904m_probe) in archive vmlinux.a
>> 
>> Fixes: 88d8f3ac9c67e ("usb: typec: add support for the nb7vpq904m Type-C Linear Redriver")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>   drivers/usb/typec/mux/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfig
>> index 8c4d6b8fb75c3..f53ae24b6c048 100644
>> --- a/drivers/usb/typec/mux/Kconfig
>> +++ b/drivers/usb/typec/mux/Kconfig
>> @@ -37,7 +37,7 @@ config TYPEC_MUX_INTEL_PMC
>>   
>>   config TYPEC_MUX_NB7VPQ904M
>>   	tristate "On Semiconductor NB7VPQ904M Type-C redriver driver"
>> -	depends on I2C
>> +	depends on I2C && DRM
>>   	select REGMAP_I2C
>>   	help
>>   	  Say Y or M if your system has a On Semiconductor NB7VPQ904M Type-C
>
> I think it could be :
>
> +	depends on DRM || DRM=n
> +	select DRM_PANEL_BRIDGE if DRM

As far as I can tell, this would only avoid the link error
against devm_drm_of_get_bridge(), but not the one against
devm_drm_bridge_add(), which is defined in drm.ko through
drivers/gpu/drm/drm_bridge.c.

    Arnd
