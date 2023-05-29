Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192CC71453B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 09:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjE2HH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 03:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjE2HHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 03:07:54 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1045EA3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 00:07:53 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2af7081c9ebso30949831fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 00:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20221208.gappssmtp.com; s=20221208; t=1685344071; x=1687936071;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zat1KHzLwak5upaRhqnvlEdQ0l9XbwNBWO76a0Xz0Tg=;
        b=kEHoR0/34wRGf2josYa7LJCkcMHDN54afmtrz+AanwOxVC8r521E0DbmUsUBITSJ/t
         VmDEL/uvcAxKqtGCqkWRBEOvCptDMAamq8kP1xJ1N3X7Iu0OdfiIGAljFJ83iIexBCTz
         EsZbB4sreHvD5690UEP6XOq7a5iAJ/RGz6Sh+2l2ufvQ9dg/FhCQiGuxRBE4MdGX+Sk8
         9aAL1RlkhWKiox3Ofr5cjfwloQesUQGkTHH6r8+tzdXtGyEUeyazSHfR8Sex1iy2X71Z
         h+HMLKs6KTu2d/YQQGlFDFlljdElJgBQzqNyPRxgkuU3BEf/nRflQglede6Tbb4zGi1I
         j/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685344071; x=1687936071;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zat1KHzLwak5upaRhqnvlEdQ0l9XbwNBWO76a0Xz0Tg=;
        b=fEnJhg0RC2JOxwbCW/0aWQrRHPNphF79f/c9ms/pZ7Aa6XQetmQjVTyCA4Ork/hzFP
         IRmoBJNceyO7sKPZoEBPLAd18IHX9te3xHLreNwugS4WgP9gIgphqZq6vza4agn83+Ec
         OfFG+VQ+Yulvg9MC/4xv/2hAPYQ2JPEyoSyLs2W4pwbRc/gA1DZLWzOdCRyLmaVJamfK
         1mjtsGVDss+Sw2nxY5KsNg0N4MFKX2w7MDP3a4W7nxEnMuEmtJbsTTJt70cOJlEIB5EF
         u2f1/WjmC63iiIwxmsU5w7t2EUjFEyHacioHsYOUAsxur9fCaymUA7eGeccwL4r50qWm
         gE4Q==
X-Gm-Message-State: AC+VfDxFITs5mq6QoRQ9hhJWjleUk8bipM2JXdj9qKRapa/U8Nt1J6K+
        DSvjfq2wHB79holXpUtK0HAhKQ==
X-Google-Smtp-Source: ACHHUZ6zRzAcWj6+rNB3nrzDHboqSKGNWTeXA9bRnzXLgDNg+s+k3hk5Sly/yo5bLSos+JNzdX45DQ==
X-Received: by 2002:a2e:7313:0:b0:2af:e006:b83 with SMTP id o19-20020a2e7313000000b002afe0060b83mr3478748ljc.18.1685344070996;
        Mon, 29 May 2023 00:07:50 -0700 (PDT)
Received: from debian (151.236.202.107.c.fiberdirekt.net. [151.236.202.107])
        by smtp.gmail.com with ESMTPSA id z19-20020a2e9b93000000b002a8c32fd2f3sm2312541lji.89.2023.05.29.00.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 00:07:50 -0700 (PDT)
Date:   Mon, 29 May 2023 09:07:48 +0200
From:   =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez 
        <ramon.nordin.rodriguez@ferroamp.se>
To:     Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, horatiu.vultur@microchip.com,
        Woojung.Huh@microchip.com, Nicolas.Ferre@microchip.com,
        Thorsten.Kummermehr@microchip.com
Subject: Re: [PATCH net-next v4 6/6] net: phy: microchip_t1s: add support for
 Microchip LAN865x Rev.B0 PHYs
Message-ID: <ZHRPRBwJ5jHs6vLz@debian>
References: <20230526152348.70781-1-Parthiban.Veerasooran@microchip.com>
 <20230526152348.70781-7-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230526152348.70781-7-Parthiban.Veerasooran@microchip.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 08:53:48PM +0530, Parthiban Veerasooran wrote:
> Add support for the Microchip LAN865x Rev.B0 10BASE-T1S Internal PHYs
> (LAN8650/1). The LAN865x combines a Media Access Controller (MAC) and an
> internal 10BASE-T1S Ethernet PHY to access 10BASE‑T1S networks. As
> LAN867X and LAN865X are using the same function for the read_status,
> rename the function as lan86xx_read_status.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
> ---

I accidentally sent both reviewed-by and tested by, should only have
been reviewed-by.
