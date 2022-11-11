Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E3862641C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 23:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbiKKWCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 17:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbiKKWBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 17:01:47 -0500
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2FADE9E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 14:01:04 -0800 (PST)
Received: from localhost (ip-109-42-177-67.web.vodafone.de [109.42.177.67])
        (authenticated bits=0)
        by mx10.gouders.net (8.17.1.9/8.16.1) with ESMTPSA id 2ABM0dPj001729
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 11 Nov 2022 23:00:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1668204040; bh=ujTHVTN9EEhrRE5jIVBrDXu7TSySG2bEt4Gc20q+Xyo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date;
        b=r9MlvTdQpUHHZF4+k1uGvHGugflNo/2GuCirTrekN8v0F/crpRYATZ/CcqT3zHw7v
         lZ9AD38i/jmbJ0cPBfOojGxKDeEO62w/ML1jlb3LWkVyiuankilXHg3y6S4UwjB7r5
         8MWHEAt454yT7fo8kN+PmzHQYzgu1gaNtOeKE9Jk=
From:   Dirk Gouders <dirk@gouders.net>
To:     Lyude Paul <lyude@redhat.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Wayne Lin <Wayne.Lin@amd.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <sean@poorly.run>
Subject: Re: Regression bisected: drm/display/dp_mst: Move all payload info
 into the atomic state
In-Reply-To: <006064db584562c38ba75bff30d1b33f8995df62.camel@redhat.com>
        (Lyude Paul's message of "Fri, 11 Nov 2022 15:50:02 -0500")
References: <ghwn827862.fsf@gouders.net>
        <006064db584562c38ba75bff30d1b33f8995df62.camel@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
Date:   Fri, 11 Nov 2022 23:00:34 +0100
Message-ID: <gh5yflw3r1.fsf@gouders.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_SBL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the pointer.  I will see if I can produce some of the
wanted logs but at the earliest tomorrow, it's almost sleeping time,
here.

Dirk

Lyude Paul <lyude@redhat.com> writes:

> Thank for letting us know! Luckily I only have good news, as we've actually
> been looking into this issue for a bit now and have made a pretty good amount
> of progress. There's pretty much only one issue left for us to fix I'm fairly
> sure:
>
> https://gitlab.freedesktop.org/drm/amd/-/issues/2171
>
> If you'd like to help, there's some logs I could use someone getting to help
> me figure out the last remaining issue here.
>
> On Thu, 2022-11-10 at 23:32 +0100, Dirk Gouders wrote:
>> Hello,
>> 
>> I noticed a regression with Linus' current tree and bisected it to
>> 4d07b0bc403403 (drm/display/dp_mst: Move all payload info into the atomic state):
>> 
>> I have two monitors connected to my laptop's USB-C port and since this
>> patch, one of the monitors remains dark.
>> 
>> Please let me know if I can provide additional information that could help
>> to investigate this problem.
>> 
>> Dirk
>> 
