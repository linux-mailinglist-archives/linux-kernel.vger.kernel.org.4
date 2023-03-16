Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E156BC655
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 07:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjCPGun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 02:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjCPGuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 02:50:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413665ADC5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 23:50:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C054B61F2A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:50:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1ABFC433A0;
        Thu, 16 Mar 2023 06:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678949437;
        bh=0u6W0gqECbwgkcY6CjVwqSMWakeZhaTYYE0LQpCC3IE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IxGKMkaUkQJEzPO2bTzrVUKddEk+jTYRX0t0FHUUoHw+UM0GLb0zHxpOd6QEgauxd
         kp4g8TJ+1HWI5Qqi4mCyiJ446wz6Bd1XqjqZu++7RsvWwW94KzEPRs+H/+uStlvO5C
         jt1GhdIK2WWT/whnPVNs62W2uLF4d/HVsPY7t/UU=
Date:   Thu, 16 Mar 2023 07:50:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/14] misc: vmw_vmci: Rename kvfree_rcu() to
 kvfree_rcu_mightsleep()
Message-ID: <ZBK8O5tKj0PPM1co@kroah.com>
References: <20230315181902.4177819-1-joel@joelfernandes.org>
 <20230315181902.4177819-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315181902.4177819-2-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 06:18:49PM +0000, Joel Fernandes (Google) wrote:
> From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> 
> The kvfree_rcu() macro's single-argument form is deprecated.  Therefore
> switch to the new kvfree_rcu_mightsleep() variant. The goal is to
> avoid accidental use of the single-argument forms, which can introduce
> functionality bugs in atomic contexts and latency bugs in non-atomic
> contexts.
> 
> Cc: Bryan Tan <bryantan@vmware.com>
> Cc: Vishnu Dasa <vdasa@vmware.com>
> Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  drivers/misc/vmw_vmci/vmci_context.c | 2 +-
>  drivers/misc/vmw_vmci/vmci_event.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
