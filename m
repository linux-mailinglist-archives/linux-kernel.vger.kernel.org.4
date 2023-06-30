Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E111743AE8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 13:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjF3LeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 07:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbjF3LeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:34:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBF381FE4;
        Fri, 30 Jun 2023 04:34:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D8F2D75;
        Fri, 30 Jun 2023 04:34:47 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E91BC3F64C;
        Fri, 30 Jun 2023 04:34:01 -0700 (PDT)
Date:   Fri, 30 Jun 2023 12:33:59 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] firmware: arm_scmi: Add optional flags to
 extended names helper
Message-ID: <ZJ69pyXOSzMv8Jad@e120937-lin>
References: <cover.1686063941.git.oleksii_moisieiev@epam.com>
 <2ad06a5582bb31e16fe2f497e15cb41e8455e863.1686063941.git.oleksii_moisieiev@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ad06a5582bb31e16fe2f497e15cb41e8455e863.1686063941.git.oleksii_moisieiev@epam.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 04:22:27PM +0000, Oleksii Moisieiev wrote:
> Some recently added SCMI protocols needs an additional flags parameter to
> be able to properly configure the command used to query the extended name
> of a resource.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Hi,

This patch was originally at:

https://lore.kernel.org/linux-arm-kernel/20230505201440.3196734-1-cristian.marussi@arm.com/

but after applying your series with B4 I can see this patch with you as
Author and me as Signer :P ... not sure what has gone wrong but, in general
you should not change Authorship of a someone else patch that you picked in
your series unless you compeletely reworked it; if you changed it slighlty
you should note your changes near your Signed-Off, which is, indeed the other
thing missing here: if you post someone else patch you should add your
Signed-Off too as last.

An example of this in this commit: 7885281260f9b952dc66b67182a2218b01e7859f

Now, I really dont care about Authorship here (but note this also meant Andy
shouted at you instead of me .. :P), but the Signed-Off and Author
mismatch has to be fixed at least, like it is now wont be accepted for sure.

Maybe the missing part is in your mail-client not prepending the From:
line when the sending other people pacthes....git send-email does it
automatically I think but others MUAs dont know.

More detail here, in case you have not seen it already:
https://www.kernel.org/doc/html/v4.10/process/email-clients.html

Thanks,
Cristian
