Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7712862DA95
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbiKQMXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiKQMXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:23:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96A4DED8;
        Thu, 17 Nov 2022 04:23:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81752B82032;
        Thu, 17 Nov 2022 12:23:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B336C433C1;
        Thu, 17 Nov 2022 12:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668687818;
        bh=bUlvDWenMKOSW37r6XauBtynPOLrrbofXsL89kzAaF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p8BAEB2SjFfIOkqSlOYMeppqsk6LHwbMJhRPlImqSWbXJwbBBdSgKvZ+036+lURBk
         AdmapwZen3cryovwwnGXxLmlqCQMRJ/UnrBbBTW0CW59mtSFbTBV7bc+crAIPPlDLF
         hbFuN+YJ7jK8Ky9Xbn4xZtXqSs9BxrCAZgxp3p0S6/6DPA0g3Uo821wXTgI5q7DfoV
         v1r5ASQIDDHAg6xa0TedOWOVBLc7eTlA9YatpJsQxi5H2RbuTO0yiMJG5FALgx+2ZZ
         kUQzgdbXiT7an7eJuv6MJovoYJWsJXWI0Fw84Rz5xTQyYqxOxyenvcdvLdgCGnaW3Y
         gE5iX2nrvaRoA==
Date:   Thu, 17 Nov 2022 13:23:35 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: Re: [PATCH v7 5/6] doc: Document CONFIG_RCU_CPU_STALL_CPUTIME=y
 stall information
Message-ID: <20221117122335.GD839309@lothringen>
References: <20221111130709.247-1-thunder.leizhen@huawei.com>
 <20221111130709.247-6-thunder.leizhen@huawei.com>
 <20221116225507.GA839220@lothringen>
 <1d007125-9e1a-8018-d6b4-8838ecc1a873@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d007125-9e1a-8018-d6b4-8838ecc1a873@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 10:03:17AM +0800, Leizhen (ThunderTown) wrote:
> On 2022/11/17 6:55, Frederic Weisbecker wrote:
> > On Fri, Nov 11, 2022 at 09:07:08PM +0800, Zhen Lei wrote:
> > One last question I have. Usually all these informations can be deduced by
> > just looking at the stacktrace that comes along an RCU stall report. So on
> > which kind of situation the stacktrace is not enough?
> 
> Interrupt storm.

Now that makes sense :)

Thanks.

> 
> > 
> > Thanks.
> > .
> > 
> 
> -- 
> Regards,
>   Zhen Lei
