Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECAE6B9F57
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 20:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjCNTGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 15:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjCNTGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 15:06:50 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB222B2A7;
        Tue, 14 Mar 2023 12:06:31 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Pbjg43XnMz49Q4J;
        Tue, 14 Mar 2023 21:06:24 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1678820786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yKx+lb5WLm5CP4bEB98GQrBYtZsW8RpnNc4soWPz9D4=;
        b=GCEeTyGroXJqbf3duk2LvvTfKjzzmdAy+PgL6w6B46hUQiNM3o4bokURg5QjBXbSyRY9op
        0TVDsZ97gU3wGUqr1pKx1ah7+2BwXDeg52JLvm8CvLtKJrMriaGOmuN0QtR+EkDx+aUkzX
        9yp7SAAGEsVqAXe7vT2BxC6wFivcaQs4nB0SzTQ/gYG6rW4DqcxasnjafoNajiOJ2CUSln
        h7husOv4kqXhb80hONmfJNq49mCrRPFWDP402zhFVqf7Iaw6rMTWc7HPx5v+noORJ9HsVc
        kJ3qjYppdhBZhyf5quHIY+RNWXzk56tipYgHqSjRrW2AhzdMvzROePVYBCj5/g==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1678820786; a=rsa-sha256;
        cv=none;
        b=dEZZWFtN3n1ODQxPicIBDbvYKD4exOBi19VkguV7BavPWB5KPAALOL9QE05/eSv63vX7uH
        nKaT4D4Tq2wBZD2UfbsJSHBO6m80XhEhglz4vQaTyfaUdau+WSuYVj9X/JQdWyBTW+EIS7
        1sPiF3xEEE10iyWZUpSGDhwmaeUsmfxlMNM0xFUXvfWgLvnOkTL+ueTGQB5bDtc1WSbok7
        +p/l+dpfrNgi51wvtj8+T7Lul8xgUEEPf17XxdDNqUG6EctECJH/HQNf7j0IBMfNkYKZ2N
        ct1HrYNpV6kx6oFBl3jck0ZsBqEgujTLM+Q4fyPUe5ZDX6DJeYtib+vq1NXzoA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1678820786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yKx+lb5WLm5CP4bEB98GQrBYtZsW8RpnNc4soWPz9D4=;
        b=V4mC+rvMKVksYXS+08sydzOyWpNANSqh6qOjG1migkQN+OyAGdosTyCTbxNM3X7A9C8sIn
        zrWL5Dj2401lqu4rR/xEoEV0l61mKSLTpWY7qyvXYXpxzkt9TLJTCcIm4wsA/i6bZG/l4/
        F2Wr8fmhVhUE64j60Z5JLz1U3UXeYvoHgj7GJCtNOjCs7Bm37gbpVR+W+Hv6ecoSBpWLRR
        rkp6dgyGylv/MEJYBlNeut4WaZfmxz68cb25p7p09f+Abi+ux2ByYgq6bk3Me8Q0/glP3f
        U+OLeyJ4s64GwDO0ngvb0J1OHkFgqNd63+oR6Uk02GZ9n1Ehr39HwBJYYFhYBw==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 717B3634C91;
        Tue, 14 Mar 2023 21:05:21 +0200 (EET)
Date:   Tue, 14 Mar 2023 21:05:21 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     shravan kumar <shravan.chippa@microchip.com>
Cc:     paul.j.murphy@intel.com, daniele.alessandrelli@intel.com,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v12 5/5] media: i2c: imx334: update pixel and link
 frequency
Message-ID: <ZBDFcXYeK0eB9i1v@valkosipuli.retiisi.eu>
References: <20230301073412.1204574-1-shravan.chippa@microchip.com>
 <20230301073412.1204574-6-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301073412.1204574-6-shravan.chippa@microchip.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shravan,

On Wed, Mar 01, 2023 at 01:04:12PM +0530, shravan kumar wrote:
> @@ -885,7 +895,13 @@ static int imx334_init_pad_cfg(struct v4l2_subdev *sd,
>  	struct v4l2_subdev_format fmt = { 0 };
>  
>  	fmt.which = sd_state ? V4L2_SUBDEV_FORMAT_TRY : V4L2_SUBDEV_FORMAT_ACTIVE;
> -	imx334_fill_pad_format(imx334, &supported_modes[0], &fmt);
> +	fmt->format.code = imx334->cur_code;

This does not compile.

> +	imx334_fill_pad_format(imx334, imx334->cur_mode, &fmt);
> +
> +	__v4l2_ctrl_modify_range(imx334->link_freq_ctrl, 0,
> +				 __fls(imx334->menu_skip_mask),
> +				 ~(imx334->menu_skip_mask),
> +				 __ffs(imx334->menu_skip_mask));

You're not holding imx334->mutex here, as you should. Also accessing
imx334->cur_code should only be done while that mutex is acquired.

What's the purpose of calling __v4l2_ctrl_modify_range() here, all these
values are static once probe() function has been called, aren't they?

I'm dropping this patch for now, taking the first four.

>  
>  	return imx334_set_pad_format(sd, sd_state, &fmt);
>  }

-- 
Kind regards,

Sakari Ailus
