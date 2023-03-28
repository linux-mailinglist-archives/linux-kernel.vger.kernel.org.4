Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AED06CB7FF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjC1H1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjC1H05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:26:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D4602111;
        Tue, 28 Mar 2023 00:26:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36E71C14;
        Tue, 28 Mar 2023 00:27:40 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FEF73F73F;
        Tue, 28 Mar 2023 00:26:54 -0700 (PDT)
Date:   Tue, 28 Mar 2023 08:26:47 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, sudeep.holla@arm.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        nicola.mazzucato@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH 1/2] dt-bindings: firmware: arm,scmi: Support mailboxes
 unidirectional channels
Message-ID: <ZCKWt0FpSguUgUel@e120937-lin>
References: <20230327140342.222168-1-cristian.marussi@arm.com>
 <20230327140342.222168-2-cristian.marussi@arm.com>
 <dd8d1503-e2bf-7032-4d0a-16d9a5b2aa51@linaro.org>
 <ZCG154hlWbLMAzIi@e120937-lin>
 <1838b760-c911-cb0a-184e-150df2f86c3b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1838b760-c911-cb0a-184e-150df2f86c3b@linaro.org>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 08:36:51AM +0200, Krzysztof Kozlowski wrote:
> On 27/03/2023 17:27, Cristian Marussi wrote:
> >>> +  - |
> >>> +    firmware {
> >>> +        scmi {
> >>> +            compatible = "arm,scmi";
> >>> +            mboxes = <&mhu_U_tx 0 0>, <&mhu_U_rx 0 0>;
> >>> +            shmem = <&cpu_scp_lpri0>;
> >>> +
> >>> +            #address-cells = <1>;
> >>> +            #size-cells = <0>;
> >>
> >> I don't think adding one more example with difference in only one piece
> >> is needed here.
> >>
> > 
> > Mmm, I thought was sensible to add this example, given that a mailbox
> > transport configuration for a mailbox exposing unidrectional channels is
> > quite different from the usual bidirectional channel config already
> > present in the pre-existent example.
> > 
> > I'll add mbox-names into this example and see if I can change your
> > mind...or I can then finally drop it.
> 
> And what exactly this one more example changes? Does not validate
> different parts of the binding if only one property differs...

Well it showcases how the extended new mboxes/shmem prop can be used in
to support such unidirectional channels (which is pretty much different
from the usual existing biridrectional synatx) ... anyway I never really
thought as the examples in terms of validation really (and I am not saying
that this is right eh) ... but more as an aid to help the unfortunate
human being that has finally to write some DT based on this.

Anyway since it does not seem appropriate, I'll just drop the whole
example in V3, after waiting for some more (if any) feedback on the
binding in general. Are the mbox-names fixes I added in V2 fine ?

Thanks,
Cristian
