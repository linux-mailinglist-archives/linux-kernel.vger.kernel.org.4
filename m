Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F72C63C672
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 18:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbiK2Ra6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 12:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235803AbiK2Raz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 12:30:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32E7A697EF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:30:55 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1ED7DD6E;
        Tue, 29 Nov 2022 09:31:01 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14BB03F67D;
        Tue, 29 Nov 2022 09:30:52 -0800 (PST)
Date:   Tue, 29 Nov 2022 17:30:50 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     Ludvig =?iso-8859-1?Q?P=E4rsson?= <Ludvig.Parsson@axis.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firmware: arm_scmi: Resolve dependency with TEE subsystem
Message-ID: <Y4ZBypmGvVLrH5iT@e120937-lin>
References: <20221111095313.2010815-1-sumit.garg@linaro.org>
 <20221111143800.k7xje6g23ujefnye@bogus>
 <CAFA6WYMdNjbMRZxt3iicmKOhQa3ax7_HYtqmNN9bmpndqT8e9A@mail.gmail.com>
 <20221114102650.qwkaxtnstujaiu6u@bogus>
 <CAN5uoS8SArNmaxwhJ=tRCPD8ue1D8VvQyLacDDS2sunfg4gLbw@mail.gmail.com>
 <b0bc03f9f2a5afbe3a77b81648a765348073cc36.camel@axis.com>
 <Y30LXW5Elcur5mlI@e120937-lin>
 <0b24b15bfee6d97d23caf0225d264c14e0ed48f1.camel@axis.com>
 <Y4X35fXiPHQ5b0cG@e120937-lin>
 <CAN5uoS8pFOLqZ3Jd7rHCisUcJvVkfWQqnOE=DUGyC3EURGLsFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN5uoS8pFOLqZ3Jd7rHCisUcJvVkfWQqnOE=DUGyC3EURGLsFg@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 03:57:50PM +0100, Etienne Carriere wrote:
> Hi Cristian, Ludvig,
> 

Hi Etienne,

> For info, I've tested your patches Cristian on my setup.
> they did the job for probing optee transport at module initcall level.
> 

Thanks for testing, I'll keep you in CC when posting the final series.
Cristian

