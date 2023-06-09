Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A31729F45
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241925AbjFIPyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241045AbjFIPxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:53:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D7E3AAD;
        Fri,  9 Jun 2023 08:53:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6B456598C;
        Fri,  9 Jun 2023 15:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4525DC433D2;
        Fri,  9 Jun 2023 15:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686326023;
        bh=pdVAWIONp7mGyDoWb5sxVQKNovTxaxkF8ARUH7UHcvw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=kOGEy+bJtU/YcoAShZWvMTlA4DrphAUGP7N7fxKFYiwB3l83PfAPRKHS9gro6V1xo
         JvDc8Xf1YVDmVZ/HWD1IzLNNJG8+38h8mr7xGJirZ9XX44Zvmf0S40NSJ4U6F2/iwB
         B+/EEUql13GLk0C5i3lKih6/QNWWYwkZcABSHbCSaIcfTdLtCsf4WzEn3x+snNzP5B
         VtkrS78f5/R8kbgq4JvSU59HYRvO0d59Evu6ho4hLu6u/xcbW6opfEsU2L/zXgvyVl
         6TVFt2Zn8Fyih5XG/c4J6d+r89DA/t0j4uGoMPb2OMP/qKU9tbMAfLjwtaYWEpwRvE
         0vh36lk0sgMPA==
Date:   Fri, 9 Jun 2023 17:53:39 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Rahul Rameshbabu <rrameshbabu@nvidia.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v1 0/3] HID: nvidia-shield: More functionality on
 top of initial driver
In-Reply-To: <20230529222052.68913-1-rrameshbabu@nvidia.com>
Message-ID: <nycvar.YFH.7.76.2306091753020.5716@cbobk.fhfr.pm>
References: <20230529222052.68913-1-rrameshbabu@nvidia.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2023, Rahul Rameshbabu wrote:

> This patch series introduces more functionality on top of the initial
> nvidia-shield HID driver sent to the linux-input mailing list. The android
> media buttons, capacitive slider, and led on the Thunderstrike controller
> are now supported. If possible, would appreciate an acknowledgment of the
> initial driver patch or more feedback if needed.
> 
> Link: https://lore.kernel.org/linux-input/20230418203747.24000-1-rrameshbabu@nvidia.com/
> 
> Rahul Rameshbabu (3):
>   HID: nvidia-shield: Add mappings for consumer HID USAGE buttons
>   HID: nvidia-shield: Support LED functionality for Thunderstrike
>   HID: nvidia-shield: Remove space prefix from label in
>     shield_haptics_create

Applied first 1/3 and 2/3 on top of for-6.5/nvidia; the third one was not 
needed, as that branch is based on v4 already.

Thanks,

-- 
Jiri Kosina
SUSE Labs

