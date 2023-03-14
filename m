Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC9C6B88D1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 04:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjCNDB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 23:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCNDBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 23:01:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51DD1E9C7;
        Mon, 13 Mar 2023 20:01:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E947B811DA;
        Tue, 14 Mar 2023 03:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB8DC433EF;
        Tue, 14 Mar 2023 03:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678762881;
        bh=f620CqCwGXqr8TZeAJQjlq7Il+ZtFOFopAaFMsR+9Yc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iVnNFK0lyWTiFdIMAMPcPXV+DqeTaUB6bZMuh0l42caxl3jQGJQVrHAgYc+dwdR8I
         2fYIRWVtRM8aYKYJ4tKlDFGlDICciZJVYFjYfmHFYyqeLxu1VU/lHaXvU1dtAVkjAk
         Fu2SgaxWskMqcyFD/QekNOcSeJaZ7kG0QyUo51FRLAfqHRLWUEhxBA1Lhsnxfiq+Wl
         3VZ30jlJhZkyePfdXq/OAwsOxlA9eqB0YdAsV7XhxFhljqM8PbfN7GvBfQiEC6fu8A
         yvKWwMCl3xaHHpjrx2cwGUzLtQ83I6W6iilv8dQl1qG1PFAor5rVX/ilWMP3J2/V2G
         hKeihT0tN0xkg==
Date:   Tue, 14 Mar 2023 11:01:14 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     devicetree@vger.kernel.org, s.hauer@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        linux-imx@nxp.com, linux@armlinux.org.uk, arnd@arndb.de,
        alistair23@gmail.com, kernel@pengutronix.de, festevam@gmail.com,
        jernej.skrabec@gmail.com
Subject: Re: [PATCH v4 0/3] imx7d-remarkable2: Enable cyttsp5 and rohm,bd71815
Message-ID: <20230314030114.GK143566@dragon>
References: <20230227045023.560319-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227045023.560319-1-alistair@alistair23.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 02:50:20PM +1000, Alistair Francis wrote:
> Enable the cyttsp5 and rohm,bd71815 in the device trees and
> defconfig for the reMarkable 2.
> 
> v4:
>  - Fixup the rohm changes to match DT schema
> v3:
>  - Remove unused sleep states
> v2:
>  - Fixup DT formatting issues in path 3
> 
> Alistair Francis (3):
>   ARM: dts: imx7d-remarkable2: Enable the cyttsp5
>   ARM: imx_v6_v7_defconfig: Enable rohm,bd71815
>   ARM: dts: imx7d-remarkable2: Enable the rohm,bd71815

Applied all, thanks!
