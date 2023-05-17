Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55040706A7E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjEQOEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjEQOEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:04:12 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B922E58;
        Wed, 17 May 2023 07:04:11 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4QLvwg1DH4z49Q47;
        Wed, 17 May 2023 17:04:03 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1684332243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F9dB5jfPE0ZTFCjOnm24Lze21kK2ZvFO8Uv2gcQfgfY=;
        b=K66yeZ1o6g42gX3bNGnxD3PL6onWkDhVcqbb4//yDM5OVbrJO6Mb9BmSKWqTG0av8GKmJ4
        tvPrcE0kXyhjjeA+UaTYjZMvfv7a3Ds9aXYxbET00sc/WRg6uCUlIJljzNsmrZ/aj4P2Sg
        6P95ebWDMpR73Vt/VFp7F5qBC+lqFWXzvdLehoY65cAIjxQ5RsyRiHFJDeyNg2fj0x8FOT
        IsjLqqFsQO2zRvvsOnG+qAlG9/EaWV6a+UbLPgzGdUOBHq4uibpJOs01hxZ3jUmX/pI98X
        AZwDMWMGRlW5lqgkfKkDKg3Cd/lt2WSL+bCRfX6ijjnzmqp/K2EAdMIRAagKpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1684332243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F9dB5jfPE0ZTFCjOnm24Lze21kK2ZvFO8Uv2gcQfgfY=;
        b=v523sTRIXZpWFCe4PqZWhgSv4kTAQYjGRoxHaFQIzJZrKFvLLPTDLYl3Yb69zNftUvrQeg
        Kwuhqo2Jcme4714QO/2gVY4i7i9iyzzH5iBOsPUchZB4wPzgFjzL+cWxSD5knYmtquL2ZE
        oOU7pv2wPmU+LP6jOrbIP+gszp4JD+FGVhG3b8omdeRBCPBjMNbygY/j3yzvijswWfeIxg
        EuxqSaojsoMIGgkL0AJIXjIy9au3KWoXSPb5YrCyJds136aE5ki+bzPZp/u4JW2Da6Fl35
        xNHRbkQsoRsWoIuutbAr133aSs9pfVv2kPSQndJVFyuWKSUXwqWIAD6IBl+6DA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1684332243; a=rsa-sha256;
        cv=none;
        b=qQBl3cRVCUGD1iDNIfJPyhRAIO8xrdyQx3uEezI1IiygR1az9UeQCF6s1QXxAAjH79dDey
        u3e6un9WVBfAw2285yjy2RLAne4/z/M5odAE4z2iQ3J440E4WLph05t1lULOTa5LIu0zOy
        rz5EfovJqwieUIYnRfJXd6pw22WL9tVvGBGECRsHlAd/fa0mNx2zTwi2vbBbWZ7XAxsdDJ
        JTGxKGnU2TvyhBdAkGiOH1FBw6W6zvpRNUh3gvAz/S61UZKgS4sVlPurtQXNNJ/7OEvmN+
        iRGppv3k6vpTP1gFXcKQQ8e9xeYigpJXOEo+T7PXsdBl6hpo64qwJUcAu25/lg==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 8C066634C94;
        Wed, 17 May 2023 17:04:02 +0300 (EEST)
Date:   Wed, 17 May 2023 17:04:02 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     shravan kumar <shravan.chippa@microchip.com>
Cc:     paul.j.murphy@intel.com, daniele.alessandrelli@intel.com,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v13 1/1] media: i2c: imx334: update pixel, hblank and
 link frequency
Message-ID: <ZGTe0ldLYb4QYZGp@valkosipuli.retiisi.eu>
References: <20230414123311.23923-1-shravan.chippa@microchip.com>
 <20230414123311.23923-2-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414123311.23923-2-shravan.chippa@microchip.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 06:03:11PM +0530, shravan kumar wrote:
> From: Shravan Chippa <shravan.chippa@microchip.com>
> 
> Update pixel_rate and link frequency for 1920x1080@30
> while changing mode.
> 
> Update vblank value while changing mode
> 
> Add support to handle multiple link frequencies.
> 
> Add dummy ctrl cases for pixel_rate and link frequency
> to avoid error while changing the modes dynamically.
> 
> Update default link frequency from device tree max link
> frequency value.
> 
> Update init_cfg() function to update the link frequency
> menu_skip_mask value.
> 
> Suggested-by: Sakari Ailus <sakari.ailus@iki.fi>
> Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>

Applied with the following diff:

diff --git a/drivers/media/i2c/imx334.c b/drivers/media/i2c/imx334.c
index d4c9986aee597..93fc1716e00a1 100644
--- a/drivers/media/i2c/imx334.c
+++ b/drivers/media/i2c/imx334.c
@@ -118,6 +118,7 @@ struct imx334_mode {
  * @vblank: Vertical blanking in lines
  * @cur_mode: Pointer to current selected sensor mode
  * @mutex: Mutex for serializing sensor controls
+ * @menu_skip_mask: Menu skip mask for link_freq_ctrl
  * @cur_code: current selected format code
  * @streaming: Flag indicating streaming state
  */


-- 
Sakari Ailus
