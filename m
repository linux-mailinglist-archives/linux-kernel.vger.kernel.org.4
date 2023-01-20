Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4C267537F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 12:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjATLiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 06:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjATLiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 06:38:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D68718A0F9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 03:38:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 312DD2F;
        Fri, 20 Jan 2023 03:38:48 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B914C3F71A;
        Fri, 20 Jan 2023 03:38:04 -0800 (PST)
Date:   Fri, 20 Jan 2023 11:38:02 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        james.quinlan@broadcom.com, Jonathan.Cameron@huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com, quic_kshivnan@quicinc.com
Subject: Re: [PATCH v8 00/17] Introduce a unified API for SCMI Server testing
Message-ID: <20230120113802.azac2q6rqoozlpdi@bogus>
References: <20230118121426.492864-1-cristian.marussi@arm.com>
 <CAKfTPtBUQS9D3nJLD5RPbOAs76ZdGhaX50_ns_Qm3X+UbZb-1w@mail.gmail.com>
 <Y8plUOoQu7G9PQXZ@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8plUOoQu7G9PQXZ@e120937-lin>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 09:56:32AM +0000, Cristian Marussi wrote:
> On Fri, Jan 20, 2023 at 09:11:24AM +0100, Vincent Guittot wrote:
> 
> Hi Vincent,
> 
> thanks for trying this out.
> 
> > I haven't seen a description of the <M>. I figured out that this is
> > the protocol id to which the channel was associated in DT while
> > testing it but it could be good to describe this somewhere.
> 
> Ah, damn yes, I had made a note to myself to add an explicit description
> of how the channel number IDs are chosen, then I forgot :P
> 
> I'll add a follow-on patch once is queued.
>

Please post it ASAP so that I can include it before I tag, just trying
to avoid missing it now and sending it as fix later :).

> > Apart from this minor thing, I have tested it with an scmi server
> > embedded in OPTEE and run the scmi compliance tests. Everything works
> > fine using the default mode or using one specific channel.
> > 
> > FWIW
> > Tested-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks Vincent and Florian. I just pulled and merged this last night, will
update to include your Tested-by tags.

--
Regards,
Sudeep
