Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A98D6273A7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 00:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbiKMX5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 18:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiKMX5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 18:57:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2926FD2DD;
        Sun, 13 Nov 2022 15:57:18 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668383836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y+DTmX2H3mUqKTAOQKtNi0S83Q3uIN6DgGFFcu/NjmI=;
        b=E89wh8Y1dqQ8dwogc+EuIbW7nyefxqza30qsFhvqYcR4GzqVPgK41IIeKvGApd/WHPFHHm
        8qexkvn6vTplPnJXbLnEtdKCi9Tn36iEqmrY6l5GrO2KSPcU3vPnpSSXSNIC0VNCDHith7
        tsGuZZEcYR55wnHrHidKexH6kPj46pfwaBMsmAY6iyMCEG8RPFry6iPDNLNg7ll7gzW5Oo
        hWCtPvvk5OckdyAThgds5mc+pHyreCnxU1d+4BEv8os4yGKOP7qe2KKxFUDTNfJNMAqK37
        NTOQ95MXtxPVRF7LGoKGIWF8ei54fD1D1B7SgrgCfuPoZjI52wfzzIKHSLMvwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668383836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y+DTmX2H3mUqKTAOQKtNi0S83Q3uIN6DgGFFcu/NjmI=;
        b=l2a8NQ5xfObkOp8eDX70hPhfNwQmIKBbHSFGRvXedvr9KDZcgxFuKCVN1duL9tsCncfGYN
        EC/Vn4yoLREis+Aw==
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Sven van Ashbrook <svenva@chromium.org>,
        Rafael J Wysocki <rafael@kernel.org>,
        linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>
Cc:     S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>, rrangel@chromium.org,
        Rajat Jain <rajatja@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mark Gross <markgross@kernel.org>
Subject: Re: [RFC v2 3/3] platform/x86/intel/pmc: core: Report duration of
 time in HW sleep state
In-Reply-To: <20221110064723.8882-4-mario.limonciello@amd.com>
References: <20221110064723.8882-1-mario.limonciello@amd.com>
 <20221110064723.8882-4-mario.limonciello@amd.com>
Date:   Mon, 14 Nov 2022 00:57:15 +0100
Message-ID: <87y1ses90k.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10 2022 at 00:47, Mario Limonciello wrote:
> intel_pmc_core displays a warning when a suspend didn't get to a HW
> sleep state.

Where? Copy and paste is wonderful...

