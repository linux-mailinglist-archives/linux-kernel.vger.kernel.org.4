Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EB05BACA0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiIPLlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiIPLlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:41:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C53E25290;
        Fri, 16 Sep 2022 04:40:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 985E61063;
        Fri, 16 Sep 2022 04:41:05 -0700 (PDT)
Received: from [10.57.48.93] (unknown [10.57.48.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D50583F71A;
        Fri, 16 Sep 2022 04:40:57 -0700 (PDT)
Message-ID: <f8c9a6ce-aec8-e13a-7c68-93152bf67383@arm.com>
Date:   Fri, 16 Sep 2022 12:40:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH] coresight: acpi: add support for amba dma-330 controller
To:     Vijayenthiran Subramaniam <vijayenthiran.subramaniam@arm.com>,
        rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        thomas.abraham@arm.com
References: <20220916111912.42733-1-vijayenthiran.subramaniam@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220916111912.42733-1-vijayenthiran.subramaniam@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

nit: on subject. This has no relation to CoreSight. This
could be :

acpi: amba: Add support for xyz.


Suzuki
