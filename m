Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626D46FF95C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 20:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239062AbjEKSJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 14:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238953AbjEKSJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 14:09:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBE97DAA;
        Thu, 11 May 2023 11:09:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38F5160B00;
        Thu, 11 May 2023 18:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C66C433D2;
        Thu, 11 May 2023 18:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683828541;
        bh=aAoCJG5fBPBQHqqcyNy+cvL5bUN9yjIgu2mpTIMhZc0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JiMAALBYW5cYh1IFDpSTbByaGn1ozIUZWPS1DS8L8ovbXk+Lz13i8s0fany9nGYyO
         ro8L343/5v/hIVZRdMIYdT4ik4S0iO2cWgczLvnVyr/VtLbJ1u/Q4+pw/ksg3UqvIO
         ZNu9RGqFIBuXDrPrFX3furaxpHE4j4sy5Wwc+xLnbh4/8caZdf9FlOElkCzivwI7Jg
         NWku51O4xCyyWVNwXcWn8u0XMjNy0sI5Nu7qVmDyFiGjZTLKW0Ej86+vPqGD5/Cncs
         x71ZIGvGAsemw2PuG0UujI1QSzSYiOqub07vxnGDch9yi3NM3GUaNu7QMEcHNDku0Y
         xkQFeC4mEYBhw==
Message-ID: <8ac29644-8f84-45d1-f9c5-1e8a93fc71d7@kernel.org>
Date:   Thu, 11 May 2023 20:08:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: 0001-rtla-Add-C-cgroup-support.patch
Content-Language: en-US
To:     linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        William White <chwhite@redhat.com>
References: <cover.1683827510.git.bristot@kernel.org>
 <20230511180457.7623-1-bristot@kernel.org>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20230511180457.7623-1-bristot@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ok, today is one of those days... Ignore this email, it is the log --dry-run I tried before.

I need to automate this final checks :-)

-- Daniel
