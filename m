Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D0F6E4813
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjDQMoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjDQMoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:44:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 307EE40D4;
        Mon, 17 Apr 2023 05:44:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2513168F;
        Mon, 17 Apr 2023 05:44:56 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D2ED73F5A1;
        Mon, 17 Apr 2023 05:44:11 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, nicola.mazzucato@arm.com
Subject: Re: [PATCH v3 0/2] Add SCMI support for mailbox unidirectional channels
Date:   Mon, 17 Apr 2023 13:44:09 +0100
Message-Id: <168173504021.1886328.725776877607864800.b4-ty@arm.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230404115026.2828149-1-cristian.marussi@arm.com>
References: <20230404115026.2828149-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Apr 2023 12:50:24 +0100, Cristian Marussi wrote:
> this series aims to extend SCMI mailbox transport layer to support mailbox
> controllers that expose unidirectional channels.
> 
> SCMI communications between an agent like Linux and the platform fw server
> happens through 2 main communication channels: an 'a2p' bidirectional
> channel (called TX in SCMI parlance) used to send synchronous commands
> and receive related replies and an optional 'p2a' unidirectional channel
> (called RX) used to convey notfications or delayed responses to
> asynchronous commands possibly emitted by the platform toward the agent.
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[1/2] dt-bindings: firmware: arm,scmi: Support mailboxes unidirectional channels
      https://git.kernel.org/sudeep.holla/c/92ac94f7e176
[2/2] firmware: arm_scmi: Add support for unidirectional mailbox channels
      https://git.kernel.org/sudeep.holla/c/9f68ff79ec2c
--
Regards,
Sudeep

