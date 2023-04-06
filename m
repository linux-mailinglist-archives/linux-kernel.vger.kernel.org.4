Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459CD6D9D78
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 18:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238699AbjDFQXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 12:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjDFQXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 12:23:47 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3112D4F;
        Thu,  6 Apr 2023 09:23:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1680798040; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=O1eesfxqteSKiIdr2GdIoTQmvbnxBEZzVbYH3n/Q2TR+HeUHpXtKT0xXSMTLmtn1Pk
    GarPy6GAiYdRPnxUl5wr7kp9uGNfn6r5QxcKG+9R58bhVnPEHXtr4hQibJ6I5h27V3r5
    6cwc6G+2KfbNV06tDQY06rzTeYATLLVFpiGhupU3/58lfcYS6pAXayqYzkiNo3t6dKhj
    VbjYgdsjvJlPCinLVlERgM6GnCTG6zC5LaE53fSp+oNcuDAhfae+9TPLiT9zS+uELpk5
    dxqcXr7Er5MqehNSC1ph9jr11qk7NzgdBHDnIuEqNWK0In3oEVgURfONSFkEF7j1hVo/
    D14A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1680798040;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Vw4gdqbJKdMok54e8g7DKDgQNtZkkehkhlVi7foHU+g=;
    b=n5AX6FYxB1JPMablvoSoi7/9F/BPIJOOxTdR2Gx+g4caYY8V4OLbmG+vRGxW7IIefq
    NB5h3a5fijWwjIpcM1OL7uN0UgYA2QwuFTIrxtpxxhTlkNSClyO1LTiO95YH8qRU6y02
    +rFuYaYRd5c1h7jlFEbiPe4UGUsuHnag/MzqFyZ2YwGj1MjBWxPuLs8kQkqscctJD1W9
    n5m1gk15M8rbWwKPJiKqnrPDhS6e4LhwOWNtPmB3zpqbys2FlpP/fPUenDHoEd06xRqN
    9zGxQo5Xn0qZzd4QT+i/1j+meZUUkN9rm1rZeuF7w5EX5THJ6h53GqPb41YnZ63dXxAr
    od8w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1680798040;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Vw4gdqbJKdMok54e8g7DKDgQNtZkkehkhlVi7foHU+g=;
    b=myZG/n3NFrX4nzinQGYqeHFty+m08R2G/NQscAbO5NCbu/ZUIY2Z8XrS84YHee6oqN
    BJ+3kWqqSExDKFPB2TT8sIxbDj5LnEWrsI0QhSxSDVrQ0ruATAqVAA8unl3rJMEVdmjW
    AVWzGvtMQJQlbPnaVIldz/cEk6NRY36MIYfgazJfHvNLagYNFdGcRIqT5CPPro5w+soW
    TncGA8XnB+kGJ3pDbzyNcG8EVK8hIaWWoXll/+2h/3XI3A0X1VtQamaQkQ23hdX8QG+w
    qr8nKM5pi5yqQLSRDwGP6Nz32maFDhxu22uQRzuO41OOnvRHSLpV9/qj8xLEdKL1hCL5
    9mpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1680798040;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Vw4gdqbJKdMok54e8g7DKDgQNtZkkehkhlVi7foHU+g=;
    b=bofcmuT28wdvr6bdJqminyaXU6o8KqKkU9MyaggOh6qaF00DKPiSMqHaXNiZlG5RWU
    ve34xN05362IIbTzJ7AQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA+pvh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az36GKeD11
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 6 Apr 2023 18:20:40 +0200 (CEST)
Date:   Thu, 6 Apr 2023 18:20:34 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     amitk@kernel.org, thara.gopinath@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com,
        dmitry.baryshkov@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] drivers/thermal/qcom/tsens: Add ability to read and
 shift-in non-contiguous calibration data
Message-ID: <ZC7xSG7qVZ7vlOB7@gerhold.net>
References: <20230406145850.357296-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406145850.357296-1-bryan.odonoghue@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 03:58:47PM +0100, Bryan O'Donoghue wrote:
> On MSM8939 the last sensor has calibration data that cannot be extracted in
> one big read.
> 
> Rather than have a lot of MSM8939 specific code this series makes a generic
> modification to allow any other calibration data that is non-contiguous to
> be extracted and recovered.
> 
> For example s9-p2 takes bits 1-5 from @4b and bit 13 from @4d. The bit from
> bit13 then becomes the sixth bit in the calibration data.
> 
> tsens_s9_p2: s9-p2@4b {
>     reg = <0x4b 0x1>;
>     bits = <1 5>;
> };
> 
> tsens_s9_p2_msb: s9-p2-msb@4d {
>     reg = <0x4d 0x1>;
>     bits = <13 1>;
> };

As far as I can tell the sensor with the non-contiguous calibration data
is the one with hwid=10, so do you mean s10-p2 instead of s9-p2 here?

It's easy to mix up the numbering: Since hwid=4 is missing for MSM8939,
the sensor 9 in the calibration code downstream (TSENS9_8939_POINT*)
actually refers to hwid=10. hwid=9 is sensor 8 in the calibration code
(TSENS8_8939_POINT*).

Sensor hwid=10 was disabled for MSM8939 in the tsens driver because it
seems unused, only exists on MSM8939 v3.0, and specifically to avoid
having to handle this non-contiguous calibration data, see commit
903238a33c11 ("thermal/drivers/tsens: limit num_sensors to 9 for msm8939"):
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=903238a33c116edf5f64f7a3fd246e6169cccfa6

> On msm8939 last (hwid=10) sensor was added in the hw revision 3.0.
> Calibration data for it was placed outside of the main calibration  
> data blob, so it is not accessible by the current blob-parsing code.
>
> Moreover data for the sensor's p2 is not contiguous in the fuses. This
> makes it hard to use nvmem_cell API to parse calibration data in a
> generic way.
>
> Since the sensor doesn't seem to be actually used by the existing
> hardware, disable the sensor for now.
>
> Fixes: 332bc8ebab2c ("thermal: qcom: tsens-v0_1: Add support for MSM8939")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

So with sensor hwid=10 disabled, I think this patch series is actually
not needed? :)

Thanks,
Stephan
