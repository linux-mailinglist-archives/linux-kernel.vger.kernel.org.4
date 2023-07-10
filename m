Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F9574DD77
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 20:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjGJSi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 14:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjGJSiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 14:38:25 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2B7A1;
        Mon, 10 Jul 2023 11:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=4yz8HG+CcroNh3v9p1h/qbj6u5JCE/mk4ofgQ+MT8vE=; b=s+
        mmbPp2BHAUK8Wdo/YsKjrFDtUnYaxtknL+2Rapat/BqTOQ/lgPgRRZ1nPTQOdxfEpVi3hdn/cQqYB
        pdEcmEDV40SK0pg4mwWDlK/HD9b+tYl9gwMNV+JtSwLTF/HQ37Q5IDkT1Kht+HFWEKgADdFRMPLva
        x6DBD2hJBYjYuBI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qIvlw-000yNJ-EK; Mon, 10 Jul 2023 20:38:08 +0200
Date:   Mon, 10 Jul 2023 20:38:08 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vesa =?iso-8859-1?B?SuTkc2tlbORpbmVu?= 
        <vesa.jaaskelainen@vaisala.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Davis <afd@ti.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] net: phy: dp83822: Add support for line class driver
 configuration
Message-ID: <261cb91c-eb3a-4612-93ad-25e2bc1a7c23@lunn.ch>
References: <20230710175621.8612-1-vesa.jaaskelainen@vaisala.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230710175621.8612-1-vesa.jaaskelainen@vaisala.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 08:56:18PM +0300, Vesa Jääskeläinen wrote:
> Add support to specify either class A or class B (default) for line driver.
> 
> Class A: full MLT-3 on both Tx+ and Tx–
> Class B: reduced MLT-3
> 
> By default the PHY is in Class B mode.

Hi Vesa

Do you have a reference to 802.3 or some other document which
describes these. How does reduced differ from full? Is this really a
hardware property of the board?

Thanks
	Andrew
