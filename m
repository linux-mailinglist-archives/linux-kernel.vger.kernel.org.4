Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCACC72800B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbjFHMbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbjFHMbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:31:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6D5E43;
        Thu,  8 Jun 2023 05:31:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6437864D26;
        Thu,  8 Jun 2023 12:31:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF6CC433EF;
        Thu,  8 Jun 2023 12:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686227504;
        bh=swvMUirsxbBJ/RlKyTVG7ID5MMIKOnzoxSjGD/xzBRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z+gaFvSipD7Ksu9h3Xo8tBffHOdbLbzhbeR5caFd01NSnkZdNVK7cpdaFMTUmW9qP
         Wx/WuA0VpR1Ei/MOpc8kXGMRJpkVceV9cxTyTIRADTF+4tfERvfq0X4WFYlzab8ykW
         mLOSMdp8r87vE0j++y5IxyYD0MwxEMGRKcMAPqD6iGP1L2u+rF2KNPwzOUArQ9Kge7
         UjItATqJ9ukw445pM7LWYYo76Ll4aOcIfIcDv57ozHvMmh4vqKsK9l9iuo10oQVmV7
         fuBsU5iCtIUo0R+lfOi5x9eg8Uc12C3kOl6ZcQLYnYLG5/iO9utlMe2v/nU4PNiAXy
         w+CLJWaryTmag==
Date:   Thu, 8 Jun 2023 13:31:34 +0100
From:   Lee Jones <lee@kernel.org>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, corbet@lwn.net, arnd@arndb.de,
        gregkh@linuxfoundation.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, macro@orcam.me.uk,
        baolu.lu@linux.intel.com, yi.l.liu@intel.com, jirislaby@kernel.org,
        rostedt@goodmis.org, revest@chromium.org, gehao@kylinos.cn,
        akpm@linux-foundation.org, jgg@ziepe.ca, razor@blackwall.org,
        stephen@networkplumber.org, prabhakar.csengg@gmail.com,
        contact@emersion.fr, alex.williamson@redhat.com,
        akrowiak@linux.ibm.com, mark.rutland@arm.com,
        ye.xingchen@zte.com.cn, ojeda@kernel.org, me@kloenk.de,
        milan@mdaverde.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        sterzik@ti.com, u-kumar1@ti.com, eblanc@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com
Subject: Re: [PATCH v7 1/6] dt-bindings: mfd: Add TI TPS6594 PMIC
Message-ID: <20230608123134.GE1930705@google.com>
References: <20230511095126.105104-1-jpanis@baylibre.com>
 <20230511095126.105104-2-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230511095126.105104-2-jpanis@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2023, Julien Panis wrote:

> TPS6594 is a Power Management IC which provides regulators and others
> features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
> PFSM (Pre-configurable Finite State Machine) managing the state of the
> device.
> TPS6594 is the super-set device while TPS6593 and LP8764 are derivatives.
> 
> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/mfd/ti,tps6594.yaml   | 193 ++++++++++++++++++
>  1 file changed, 193 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps6594.yaml

Applied, thanks

-- 
Lee Jones [李琼斯]
