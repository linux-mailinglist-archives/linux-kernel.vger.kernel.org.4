Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE285B9658
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiIOI1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiIOI1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:27:05 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4028E4CB
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 01:27:03 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bj14so29589432wrb.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 01:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=AAt5Um1qIp24C5EZM4DUMW2rroXzrQ90EDC61LKlajo=;
        b=mGsuluPsSUL6X62UHtzo77I15r6c36I4qjwh6KOjO5FsOzaaGeLPMtt4Ur5vfPQdzp
         gkAoN9uHkwAOTkHUCrUXJqpM44+qwUuQeKtWg2JcK+eJbephdxZXz44TDC1mLq0kgsRC
         hYznEldd/Fe7d75V2vPX3Vx0JprxazhvkW/uJWoQVhBKXzSgLwxsYlURALGd4+MzZ4a1
         3ukxWzFXtoK8Fb028wWxGlR3LEJPK07RGh1N+QfXf38yWger6mm55UI1y+9zKhYFA45X
         UYQi4ilMKDGqPdVtNU0HaW6E6vVzhg0k4rbNIWqpaqs4pAlgLNfM65CLaycJ9rshRMgL
         WuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=AAt5Um1qIp24C5EZM4DUMW2rroXzrQ90EDC61LKlajo=;
        b=2s05oQhmdsDW4JUurzFW9e0pqjAayeIxgMldmuaeiYeM0t7pjWxHgYi7Pa8T1mpU92
         sfVRzduiFuQgIoigNOMOb3XodMrvgd6xRm6bZBu1CRoCgE7YoPvrw65r31x608gTWfWg
         7X+Z+8XMLAXP+sGJI0lcxCgF4bIAXUIXT2azE+m2/2BaDZiXjQShuA+kpEKs9BhW3PkD
         wY58xAsFRN/Va7SQDDmq+iXO7Q1IIy+4KE2vlRru9/MGA5meAvTMadvnLJLOfK/E6oe8
         bKnvUu7alfhoKxnNI9nXwn4LkREfBFRb5+G+VpfmbRGgDw8MDepomuA6EEPJ0Q5g2o4X
         oY2w==
X-Gm-Message-State: ACrzQf37N1pd+odpK9ZPL8diEG6Czk79t974X0ZgQrYzowjRSdDqFZep
        yj4ldOYU+R4d9bD62yEgMK2WmA==
X-Google-Smtp-Source: AMsMyM5V3x4cg8OpivB4MKtga9Cjeqk8hm3V19lk3CUdMYvF281jlqy+KS6tFIK6UjERi+ksLdC3uQ==
X-Received: by 2002:adf:e4cc:0:b0:22a:d755:aaf7 with SMTP id v12-20020adfe4cc000000b0022ad755aaf7mr384989wrm.692.1663230422270;
        Thu, 15 Sep 2022 01:27:02 -0700 (PDT)
Received: from ?IPV6:2a01:cb05:8f8a:1800:1c97:b8d1:b477:d53f? (2a01cb058f8a18001c97b8d1b477d53f.ipv6.abo.wanadoo.fr. [2a01:cb05:8f8a:1800:1c97:b8d1:b477:d53f])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b003b47e8a5d22sm2200081wmq.23.2022.09.15.01.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 01:27:01 -0700 (PDT)
Message-ID: <e6e7df98-c116-7d71-79a7-9f5cfef9bb94@smile.fr>
Date:   Thu, 15 Sep 2022 10:27:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 6/6] soc: ti: pruss: Add helper functions to get/set
 PRUSS_CFG_GPMUX
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>, linux-kernel@vger.kernel.org,
        Md Danish Anwar <danishanwar@ti.com>
Cc:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        nm@ti.com, ssantosh@kernel.org, s-anna@ti.com,
        linux-arm-kernel@lists.infradead.org, grygorii.strashko@ti.com,
        vigneshr@ti.com, kishon@ti.com
References: <20220418123004.9332-1-p-mohan@ti.com>
 <20220418123004.9332-7-p-mohan@ti.com>
 <94b57cbc-b865-e0b4-0d52-3da72f2dd026@smile.fr>
 <b55bbba1-16ed-dbac-05e9-25ea4661efab@kernel.org>
From:   Romain Naour <romain.naour@smile.fr>
In-Reply-To: <b55bbba1-16ed-dbac-05e9-25ea4661efab@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Roger,

Le 14/09/2022 à 15:15, Roger Quadros a écrit :
> Hello Romain,
> 
> On 12/09/2022 17:20, Romain Naour wrote:
>> +Danish
>>
>> Hi Danish,
>>
>> (Removed Puranjay (as he is no longer with TI) and adding Danish.)
>>
>> Le 18/04/2022 à 14:30, Puranjay Mohan a écrit :
>>> From: Tero Kristo <t-kristo@ti.com>
>>>
>>> Add two new helper functions pruss_cfg_get_gpmux() & pruss_cfg_set_gpmux()
>>> to get and set the GP MUX mode for programming the PRUSS internal wrapper
>>> mux functionality as needed by usecases.
>>
>> Actually I'm curious about how the GP MUX mode are supposed to work in some
>> cases. The register mapping in the AM57xx TRM seems confusing.
>>
>> See the "PRU-ICSS I/O Interface" part about the "PRU-ICSS Internal Wrapper
>> Multiplexing" [1].
>>
>> The commit "ARM: dts: am57xx-idk: Add prueth on ICSS" [2] (only in the
>> TI kernel tree) adds pruss1 and pruss2 for the am571x-idk board.
>>
>> But this commit doesn't really explain the ti,pruss-gp-mux-sel setting
>> from pruss1_eth and pruss2_eth:
>>
>>     /* Dual mac ethernet application node on icss1 */
>>     pruss1_eth {
>>     	status = "okay";
>>     	compatible = "ti,am57-prueth";
>>
>>     	ti,pruss-gp-mux-sel = <0>,	/* GP, default */
>>     			      <4>;	/* MII2, needed for PRUSS1_MII1 */
>>     }
>>
>>     &pruss2_eth {
>>     	ti,pruss-gp-mux-sel = <4>,	/* MII2, needed for PRUSS1_MII0 */
>>     			      <4>;	/* MII2, needed for PRUSS1_MII1 */
>>     };
>>
>> At the first look, the two comments in pruss2_eth node about PRUSS1_MIIx seems
>> dubious. Indeed, it would means that the PRUSS2 setting (ti,pruss-gp-mux-sel) is
>> required to makes PRUSS1 work.
> 
> Yes, if I remember right this is only applicable to AM571 Soc which had
> an overloaded pinmuxing design and it resulted in this kind of weird constraint.
> i.e. gp-mux-sel of PRUSS2 needs to be set to get PRUSS1 MII to work.

Thanks for you feed back!

From my experience the "issue" is also on the AM5749 design.

I haven't find any comment or warning from TI in the datasheet, the devicetree
or the git log about this weird constraint.

I was wondering why the PRUSS2 was used on the IDK574x board out of the box [1].
I did some hardware changes to be abble to test the PRUSS1 with prueth driver. I
was able to test an confirm that PRUSS1 was working well but the PRUSS2 was
still working.

But on my custom board, only the PRUSS1 was used with the prueth driver... so it
was not working as expected.

At least the pruss driver should check for such non working setting :-/

[1] https://www.ti.com/tool/TMDSIDK574

Best regards,
Romain


> 
>>
>> In my use case, only the pruss1 is expected to be used with the prueth driver.
>>
>> Actually, the prueth on PRUSS1 partially works with only pruss1_eth's gp-mux
>> initialized:
>>
>>     pruss1_eth {
>>             status = "okay";
>>             compatible = "ti,am57-prueth";
>>
>>             ti,pruss-gp-mux-sel = <0>,      /* GP, default */
>>                                   <4>;      /* MII2, needed for PRUSS1_MII1 */
>>     }
>>
>>     pruss2_eth {
>>             status = "disabled";
>>     }
>>
>> (Tests done with the ti-linux-kernel 5.10.y)
>>
>> On wireshark I noticed ethernet frames (ping) sent from the board but the reply
>> from the remote PC is never received on the board.
>>
>> It really seems we need pruss2_eth's gp-mux initialized.
>> The problem here is that I don't want to enable PRUSS2 just to
>> configure pruss2_eth's gp-mux for the sake of pruss1.
>>
>> I had to write manually (using devmem2) the "good" value (0x10002003) in
>> PRUSS2_CFG0 and PRUSS2_CFG1 to configure entirely the PRUSS1_MII1.
>>
>> I'm not sure how the driver should handle this register mapping properly.
>>
>> [1] https://www.ti.com/lit/ds/symlink/am5749.pdf
>>
>> [2]
>> https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/?h=linux-5.10.y&id=2a3b089f5697fe2f9a9875b2fba1bef88d196a53
>>
>> Best regards,
>> Romain
> 
> cheers,
> -roger
> 
>>
>>>
>>> Co-developed-by: Suman Anna <s-anna@ti.com>
>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>> Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
>>> Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
>>> Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
>>> ---
>>>  include/linux/pruss_driver.h | 44 ++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 44 insertions(+)
>>>
>>> diff --git a/include/linux/pruss_driver.h b/include/linux/pruss_driver.h
>>> index e2d5477225c6..3312281ef4c1 100644
>>> --- a/include/linux/pruss_driver.h
>>> +++ b/include/linux/pruss_driver.h
>>> @@ -35,4 +35,48 @@ struct pruss {
>>>  	struct clk *iep_clk_mux;
>>>  };
>>>  
>>> +/**
>>> + * pruss_cfg_get_gpmux() - get the current GPMUX value for a PRU device
>>> + * @pruss: pruss instance
>>> + * @pru_id: PRU identifier (0-1)
>>> + * @mux: pointer to store the current mux value into
>>> + *
>>> + * Return: 0 on success, or an error code otherwise
>>> + */
>>> +static inline int pruss_cfg_get_gpmux(struct pruss *pruss,
>>> +				      enum pruss_pru_id pru_id, u8 *mux)
>>> +{
>>> +	int ret = 0;
>>> +	u32 val;
>>> +
>>> +	if (pru_id < 0 || pru_id >= PRUSS_NUM_PRUS)
>>> +		return -EINVAL;
>>> +
>>> +	ret = pruss_cfg_read(pruss, PRUSS_CFG_GPCFG(pru_id), &val);
>>> +	if (!ret)
>>> +		*mux = (u8)((val & PRUSS_GPCFG_PRU_MUX_SEL_MASK) >>
>>> +			    PRUSS_GPCFG_PRU_MUX_SEL_SHIFT);
>>> +	return ret;
>>> +}
>>> +
>>> +/**
>>> + * pruss_cfg_set_gpmux() - set the GPMUX value for a PRU device
>>> + * @pruss: pruss instance
>>> + * @pru_id: PRU identifier (0-1)
>>> + * @mux: new mux value for PRU
>>> + *
>>> + * Return: 0 on success, or an error code otherwise
>>> + */
>>> +static inline int pruss_cfg_set_gpmux(struct pruss *pruss,
>>> +				      enum pruss_pru_id pru_id, u8 mux)
>>> +{
>>> +	if (mux >= PRUSS_GP_MUX_SEL_MAX ||
>>> +	    pru_id < 0 || pru_id >= PRUSS_NUM_PRUS)
>>> +		return -EINVAL;
>>> +
>>> +	return pruss_cfg_update(pruss, PRUSS_CFG_GPCFG(pru_id),
>>> +				PRUSS_GPCFG_PRU_MUX_SEL_MASK,
>>> +				(u32)mux << PRUSS_GPCFG_PRU_MUX_SEL_SHIFT);
>>> +}
>>> +
>>>  #endif	/* _PRUSS_DRIVER_H_ */
>>

