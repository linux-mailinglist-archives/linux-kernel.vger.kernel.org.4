Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD8D6EF095
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239877AbjDZJGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239757AbjDZJGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:06:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD5440D1;
        Wed, 26 Apr 2023 02:06:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3661860F36;
        Wed, 26 Apr 2023 09:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD6DC433EF;
        Wed, 26 Apr 2023 09:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682499969;
        bh=yHrtZh0ixJGqT8aNySoPLQUjxCbh6T41JHLqYEyn0zU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XdHYtgh2MAgX5StFmK7uHWefEvUpasQ+Mn4vl1ZrUG0tPojUJ+GkEBSQiocqcIP7x
         pYlxZzuz+M0FKeFkIKKzLt4re6fFqtO14JF624SkzINpacMLEUlWrjV82nS8yaBvPp
         J95cUnVzpam4N6fKdg6dTSLB9AeV/qw+Y8F6K2279vrxB3pGprBYN1UoOZrfcMl67v
         Uxwh7HW3Sz30w90keEEwH8pRDkk1QA8eFO9shm6elaRX4pzkPdoCWpf28IOaK9/jcs
         AsEpt4qGUcO1OQfiOm2OuRBllnXW87wZzbHPKIEoVIiBHpkw/cr6lZomIozpD5AmM3
         k/uU0/SU0x+5Q==
Message-ID: <75429329-e2ca-b059-f0cd-af19c5b74096@kernel.org>
Date:   Wed, 26 Apr 2023 11:06:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] docs: move tracing tools
To:     Steven Rostedt <rostedt@goodmis.org>,
        Costa Shulyupin <costa.shul@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
References: <20230425130231.912349-1-costa.shul@redhat.com>
 <20230425134824.5d57c431@gandalf.local.home>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20230425134824.5d57c431@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/23 19:48, Steven Rostedt wrote:
> On Tue, 25 Apr 2023 16:02:30 +0300
> Costa Shulyupin <costa.shul@redhat.com> wrote:
> 
>> from list of development tools to user tools
>> because these tools work on running kernel
>> and are invoked from user mode
> Wait what? No!
> 
> The trace/ directory has a lot that is kernel internal only. Yes, it may
> explain how user space can interact with it, but it's also how internal
> kernel processes can use the ftrace infrastructure, and also explains a lot
> of the kernel design of that code.
> 
> NACK!

NACK++

-- Daniel
