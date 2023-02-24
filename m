Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9A16A1C89
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 13:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjBXM6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 07:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBXM6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 07:58:03 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6BE13526;
        Fri, 24 Feb 2023 04:58:02 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so382235pjp.2;
        Fri, 24 Feb 2023 04:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677243482;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CXtEyT8xVIkUMApBSTQ3cYy66lfTrvRLYpoVJHa9vcs=;
        b=fGNjMXdOa/2jFDtcv4zjh5C+rTTvUkujg/MH7jVU3TzF9pgNNfvHMmhe9KdoxBz/IP
         nmztiOBlWTPhe8cRXO284AFl+WeBp8e9PutPukzpzZTijXvU5PcC9Nwy+uMv/Mg7/qtq
         65O0QVE2iGRv7s6zI0/YqQm+oO4XGzzePhfEJTl4EHbLKkdZRyyrGgetPgQYcn5MyOt0
         nWXkaJhYVsiaj+Q125hN1AqIJe9XEGJAPYQOZDSmCVkg9j/6QVnGvmRJ4xPlwhoxDCJb
         vwEnSRVIkmlUamNSmoPcmYEFDgUuf7R29/rCGuSskTxzfp6gAWVsKMS24m6VaAWqb/kB
         sQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677243482;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CXtEyT8xVIkUMApBSTQ3cYy66lfTrvRLYpoVJHa9vcs=;
        b=wRa8CU3XBoRzVO3GyEhciGma5ZpkYZkZ4YAuwZV3GXpaCzgbxVN3uZK/HDIM1N7ojT
         BQt/SJaxPH8pzGP7QwEQKz2+CQEj0ftGEwciH5m9mwnCuz3QA8KX2OSswrJla4rmX0G/
         qk47OkQ/dAArL9g27xRv3UIt4BKEiU2NjWkV1Lb4Ilt1uBcpL9Eim5aOGtdEof8c0oaA
         d8CqzL5ZixMS9m3W3rdHpiEAU+en1cCLo81aVYjihfjzbxErRCpgoGjsmiYe/ZtuoH57
         9YwM17BhDPANOdGEJZfZxbYAUgzhu3hAaDuUA+I8kYCf6/vcll9BU47m8xMIOFiqviRf
         FPgw==
X-Gm-Message-State: AO0yUKVylRHhQ3CJzX6mThM8OyZXOVh626uMMLIX7KPGQXS4yILsdzJk
        tpMEtER01okB7RSDpd/HUfk=
X-Google-Smtp-Source: AK7set+YzXg/RfEEChGbQ+6UrrWMwrZYY/kX2hO/BsunvHndn5j3QyvNXnxK3qAajg7VWTkoh4nCsg==
X-Received: by 2002:a17:902:d2cd:b0:19a:98fd:9c54 with SMTP id n13-20020a170902d2cd00b0019a98fd9c54mr19495973plc.35.1677243482019;
        Fri, 24 Feb 2023 04:58:02 -0800 (PST)
Received: from [192.168.1.39] (M014008005000.v4.enabler.ne.jp. [14.8.5.0])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902654200b0019a74841c9bsm6409474pln.192.2023.02.24.04.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 04:58:01 -0800 (PST)
Message-ID: <7d4a218d-8b8a-5a1d-eff8-e154bfde69be@gmail.com>
Date:   Fri, 24 Feb 2023 21:57:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] ARM: dts: mvebu: add device tree for IIJ SA-W2
 appliance
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <20230223132502.2045-1-musashino.open@gmail.com>
 <20230223132502.2045-2-musashino.open@gmail.com> <Y/d7gjqQCKKXMHqj@lunn.ch>
From:   INAGAKI Hiroshi <musashino.open@gmail.com>
In-Reply-To: <Y/d7gjqQCKKXMHqj@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

thank you for your reviews and detailed descriptions.

On 2023/02/23 23:43, Andrew Lunn wrote:
>> +		pcie {
>> +			status = "okay";
>> +
>> +			pcie@1,0 {
>> +				status = "okay";
>> +
>> +				/* Atheros AR9287 */
>> +				wifi@0,0 {
>> +					compatible = "pci168c,002e";
>> +					reg = <0000 0 0 0 0>;
>> +				};
>> +			};
>> +
>> +			pcie@3,0 {
>> +				status = "okay";
>> +
>> +				/* Qualcomm Atheros QCA9880 */
>> +				wifi@0,0 {
>> +					compatible = "qcom,ath10k";
>> +					reg = <0000 0 0 0 0>;
>> +				};
>> +			};
>> +		};
>> +	};
> These are not wrong, but they are also not needed. PCI devices should
> be discovered by enumeration, and you don't have any additional
> properties here, or phandles pointing to these nodes.
>
> I assume these are COTS wifi modules? By listing them here you are
> restricting some flexibility. The OEM could for example swap the
> modules around, and Linux would not care, but the DT would then be
> wrong. Or you could have a device with a different module because it
> is cheaper, and again, Linux would not care, but the DT would be
> wrong.

Got it. SA-W2 is not designed to allow users to swap cards under 
normal use, but certainly things like you said can happen...
I'll remove "wifi" nodes.

 > I assume these are COTS wifi modules?

Yes, those are the modules manufactured by Silex Technology, Inc. [1][2].

[1]: https://www.silex.jp/products/wireless-module/sxpcegn.html
[2]: https://www.silex.jp/products/wireless-module/sxpceac.html

>
>> +&usb0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pmx_usb_pins>;
>> +	status = "okay";
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +
>> +	/* SMSC USB2514B */
>> +	hub@1 {
>> +		compatible = "usb424,2514";
>> +		reg = <1>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		hub_port1: port@1 {
>> +			reg = <1>;
>> +			#trigger-source-cells = <0>;
>> +		};
>> +
>> +		hub_port2: port@2 {
>> +			reg = <2>;
>> +			#trigger-source-cells = <0>;
>> +		};
>> +	};
>> +};
> Same comment as PCI. However, it is likely that the USB hub is
> actually on the board, not a module, so it is a lot less likely to
> change.

Yes, that USB hub is on the PCB and wired to the SoC directly. But 
I'll keep it in mind...

>
> As i said, they are not wrong, so you don't need to remove them.
>
> 	Andrew
>

Regards,
Hiroshi
