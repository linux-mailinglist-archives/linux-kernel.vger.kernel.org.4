Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118D87113A8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbjEYS0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235058AbjEYS0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:26:07 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC943119
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 11:26:05 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f3b9e54338so2861274e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 11:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20221208.gappssmtp.com; s=20221208; t=1685039164; x=1687631164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bo/92fqAK60qaR+iLt8EZXaikaLGeCRcZg1Se+/ddps=;
        b=OnKkRBAymV1YDLhgYbcvLmDtFYPzxUui9VvwEnGeGQgCkfvYzSnq0k0Gpcao8eJrf1
         XwdcerjNtAmBfAOhixooIlqz83NMoBRuWFEoQxokD8ytJxwMqJa37vvAzoSnKuX2K7tg
         /UTJ9kceGXXh0S5IFWOWhvQ/wvymvppxEXcORe+Jq/oX0E0qKXrNRDuqVb7daMkpxqnr
         fKiykLrCQ92n9DqBVlWBhuM/uy4rWrjTAaRW7rAyU7f2JNISrcQbJJCIOrz+s0v08S3K
         IAx7jHaukTLocwbyzMSyXz/GjJTFCjgnB+FK9qJSDOa8rPj9eJPcHthwjwFKoldunCjW
         xZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685039164; x=1687631164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bo/92fqAK60qaR+iLt8EZXaikaLGeCRcZg1Se+/ddps=;
        b=FvQ1mmaRsbaipUoqNiKX8r0FArBa04sQkLbM0kcEq57x78nJzrwe/kMryRe9oMLRf5
         W2KdxI9EIIKIrm65SKXcOZb7zlZ9Hy/Z2ujSLOBDJKb0Uw2NR2/vZzYs3xjnfS7CxZTx
         mHN8z6F3GCxQ83Vw23C6muRmT4sWhbRbmg2Y40nPzeA7pb4EVBPt9eSy8NuMo2qqPyLB
         C4jFiIGeG+3Rf2ZIrs3G/PRSI3vY6NFESxRTCtC5i9QSrbXAK4YyJHV3tldWOTFsrO4G
         RvVXHUhjTI/g4Tbox4p3aJ5N+mU56njzWvOsYnf2eWBiGUV+iD9FF/Lz3Xzn5Lk6tmNK
         oZPw==
X-Gm-Message-State: AC+VfDwCQlGWzuHR3OPDoTS60/pcZp1kAtU8NfrXF8mB0i/P06mY81F8
        KywivNRJ2anKYeK1MgMP26KgKA==
X-Google-Smtp-Source: ACHHUZ7hfVDmC5/c2CGGMSMTxDbfwtPFKcneg2Z6OZXvyfDqqvmmyFE4j7I+7MnfLjS37XGhLC1cVA==
X-Received: by 2002:a05:6512:4c8:b0:4f3:aaea:6d48 with SMTP id w8-20020a05651204c800b004f3aaea6d48mr7474673lfq.63.1685039164049;
        Thu, 25 May 2023 11:26:04 -0700 (PDT)
Received: from builder (c188-149-203-37.bredband.tele2.se. [188.149.203.37])
        by smtp.gmail.com with ESMTPSA id q28-20020ac25a1c000000b004f4cabba7desm296750lfn.74.2023.05.25.11.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 11:26:03 -0700 (PDT)
Date:   Thu, 25 May 2023 20:26:01 +0200
From:   =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez 
        <ramon.nordin.rodriguez@ferroamp.se>
To:     Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, horatiu.vultur@microchip.com,
        Woojung.Huh@microchip.com, Nicolas.Ferre@microchip.com,
        Thorsten.Kummermehr@microchip.com
Subject: Re: [PATCH net-next v3 4/6] net: phy: microchip_t1s: fix reset
 complete status handling
Message-ID: <ZG+oOVWuKnwE0IB2@builder>
References: <20230524144539.62618-1-Parthiban.Veerasooran@microchip.com>
 <20230524144539.62618-5-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524144539.62618-5-Parthiban.Veerasooran@microchip.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	/* Read STS2 register and check for the Reset Complete status to do the
> +	 * init configuration. If the Reset Complete is not set, wait for 5us
> +	 * and then read STS2 register again and check for Reset Complete status.
> +	 * Still if it is failed then declare PHY reset error or else proceed
> +	 * for the PHY initial register configuration.
> +	 */
> +	err = phy_read_mmd(phydev, MDIO_MMD_VEND2, LAN867X_REG_STS2);
> +	if (err < 0)
> +		return err;
> +
> +	if (!(err & LAN867x_RESET_COMPLETE_STS)) {
> +		udelay(5);
> +		err = phy_read_mmd(phydev, MDIO_MMD_VEND2, LAN867X_REG_STS2);
> +		if (err < 0)
> +			return err;
> +		if (!(err & LAN867x_RESET_COMPLETE_STS)) {
> +			phydev_err(phydev, "PHY reset failed\n");
> +			return -ENODEV;
> +		}
> +	}

This comment explains exactly what the code does, which is also obvious
from reading the code. A meaningful comment would be explaining why the
state can change 5us later.
