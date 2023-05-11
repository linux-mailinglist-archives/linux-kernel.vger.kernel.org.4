Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888F36FF7BE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbjEKQqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238411AbjEKQqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:46:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC1F5276;
        Thu, 11 May 2023 09:46:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AAEB64FC0;
        Thu, 11 May 2023 16:46:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73CFC433D2;
        Thu, 11 May 2023 16:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683823603;
        bh=uUwdkErRNflL3QPmPN6mNt/N8z1HkUW5lwDgxS3EVm4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Gr9A2V5di04Q9Y0BvQCRNOqkC34Pk1C9pZ6feZiWhFtkUaudxIqmccqZZ83NdtN9T
         bUvLkew3So3HzovIO9fxc/fVoLfBRRxxoevR1ztI9at2yCfvzHydMvgSLhVMS6ANyG
         4EwD4m6ryOjg0Zd+hgo9Lsko7gxSHOuoOUHx3rbkp1JQrsAZWVh4UT+/NBAAVxn/n3
         R4c1OK8Eyzbwox2WcE+ybjG7r3I4VxStHHOv3SK0AdIkGpNc1ZNRjm9MBfGvZCmEa/
         u5tVsSZdVxIKPUqNViPIN57zwAU6YyHqfz0IelVG0OUoD9ZLgevfvQ+IrSSo7efK6m
         zM1uJJohDYIlw==
Message-ID: <b3192da0-0031-1d39-cb1f-acc51d86583f@kernel.org>
Date:   Thu, 11 May 2023 18:46:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Subject: [PATCH 0/2] osnoise improvements
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        William White <chwhite@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <cover.1683823114.git.bristot@kernel.org>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <cover.1683823114.git.bristot@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops....

On 5/11/23 18:45, Daniel Bristot de Oliveira wrote:
> Subject: [PATCH 0/2] osnoise improvements

