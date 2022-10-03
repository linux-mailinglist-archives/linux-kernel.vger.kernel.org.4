Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF295F3110
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 15:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiJCNWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 09:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiJCNWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 09:22:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1944140542
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 06:22:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34C3816F8;
        Mon,  3 Oct 2022 06:22:42 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80B403F73B;
        Mon,  3 Oct 2022 06:22:34 -0700 (PDT)
Date:   Mon, 3 Oct 2022 14:22:32 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Shivnandan Kumar <quic_kshivnan@quicinc.com>
Cc:     sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, quic_rgottimu@quicinc.com,
        quic_avajid@quicinc.com
Subject: Re: Query regarding "firmware: arm_scmi: Free mailbox channels if
 probe fails"
Message-ID: <YzriGCLf+MFNGO2n@e120937-lin>
References: <cfa26ff3-c95a-1986-58fc-b49fc9be49d5@quicinc.com>
 <Yyx3IAcMX309QEjB@e120937-lin>
 <Yyx/DKcc7XupQmnx@e120937-lin>
 <c81540cc-e485-0c45-9e4e-248d3279e1ea@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c81540cc-e485-0c45-9e4e-248d3279e1ea@quicinc.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 06:29:02PM +0530, Shivnandan Kumar wrote:
> hi Cristian,

Hi Shivnandan,
> 
> Thanks for your support in providing the patch to try.
> 
> I found one race condition in our downstream mbox controller driver while
> accessing con_priv, when I serialized access to this, issue is not seen on 3
> days of testing.

Good to hear that you find the issue.

> 
> As you rightly mentioned that your provided patch will impact all the other
> users.
> 
> Also if  we take your provided patch, same race still exists while accessing
> con_priv in our downstream mbox controller so this issue will still be
> there.
> 

Yes indeed, even though I think that race in the mailbox core between RX path
and chan_free could still be theoretically possible it does not seem to me
appropriate to try to fix it now that you cannot reproduce it anymore and
no other mailbox user has ever raised this concern (even though, as said, the
proper solution to that race wont probably be directly in the mailbox-core as
in my experimental two liners..)

> So, we are planning to merge the patch( serialized access to con_priv) in
> our downstream mbox controller now.
> 

Ok, just out of curiosity, once done, can you point me at your downstream public
sources so I can see the issue and the fix that you are applying to your trees ?

Thanks,
Cristian
