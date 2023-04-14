Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D766E26FE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 17:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjDNP2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 11:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjDNP2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:28:30 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4B1E69;
        Fri, 14 Apr 2023 08:27:55 -0700 (PDT)
Date:   Fri, 14 Apr 2023 17:27:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1681486064; bh=XfABgRgasUd2NUJXHP+G4ZkXCN4p5fWetmFc96ErKLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KWtwVsfuQssMtAMWq1X5TzmPuILpN1ArT4ljdrLIH1cYvDdbTsWAZk1VXYFoJp79u
         b9bswg+yjGx1kjT9n5P2RxigSIKGxPh71UTN1zVtc14ogrSgrL/hVGgJqdh/3H9W9/
         4eFfGTR/Bg1MbuHoVen13VG6t/mHrtHcH8Q/20L4=
From:   thomas@t-8ch.de
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9] HP BIOSCFG driver - Documentation
Message-ID: <f91ee2ff-3a24-4e2b-bf68-f1c5400b7462@t-8ch.de>
References: <20230412144821.5716-1-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412144821.5716-1-jorge.lopez2@hp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jorge,

On 2023-04-12 09:48:21-0500, Jorge Lopez wrote:
> [..]
>
> +What:		/sys/class/firmware-attributes/*/authentication/SPM/statusbin
> +Date:		March 29
> +KernelVersion:	5.18
> +Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
> +Description:	'statusbin' is a read-only file that returns 'status' information
> +		in binary format. This file provides a mechanism for components
> +		downstream (e.g. Recovery Agent) can read the status and public
> +		key modulus.

This is still missing docs about how to interpret the contents of the
"statusbin" file.

"components downstream" -> userspace.


I think we can start with the code review.

Could you also provide a sample of the attribute files?
I'm especially curious about the different instances of the sure-start
attributes, including current_value, possible_values and the auditlog
properties.

Also is the userspace component for this published somewhere?
If so it would be useful to refer to it from the commit message.

Thanks,
Thomas
