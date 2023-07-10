Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A457474DE7B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 21:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjGJTsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 15:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjGJTry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 15:47:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DA2197
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 12:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RL8gMwle08rmwc1C9XNEInNEb4fdM+hHaLhOFI+mdjs=; b=DhU0aoNnIOb/wEgn16WA3b8mHd
        w6rWKTWTyv1ZgG/17RmdUX77CL5JEEnZlo0N6SM7YsOqzfv2PpmNailHlmbOpr10tJV4++vdhhfQG
        MZPleGxjUIMEM8HufWOfEro2dnPzD7sOZxO7A41XQAvs81jbchbNihWXMhQ92JnW6wank1HL2Hsc4
        +lv/bsNCmg8S9pP1ksxIIDWQw09DthFvE7npFlnzvj9nON9JZVWdPhxVEnD7QBldFGwaO7R2eRcc8
        aTNUdA+J3FofNfm0TGMi2E4gvSzo3Etv5jwbTr26dfU5Dq8undjL3NZuCwIGXSmdvs6ss8yjrqM4v
        K8X6QoXA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qIwrK-00CamN-1n;
        Mon, 10 Jul 2023 19:47:46 +0000
Date:   Mon, 10 Jul 2023 12:47:46 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Li zeming <zeming@nfschina.com>, linux@rasmusvillemoes.dk,
        mbenes@suse.cz, rafael@kernel.org, linux@weissschuh.net,
        gregkh@linuxfoundation.org, christophe.jaillet@wanadoo.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: params: =?utf-8?Q?Remo?=
 =?utf-8?B?dmUgdW5uZWNlc3Nhcnkg4oCYMOKAmQ==?= values from err
Message-ID: <ZKxgYp115SWTL84u@bombadil.infradead.org>
References: <20230711194331.4361-1-zeming@nfschina.com>
 <1408364e-6b73-7b50-e61c-470f3548a3a7@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1408364e-6b73-7b50-e61c-470f3548a3a7@infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2023 at 08:33:28PM -0700, Randy Dunlap wrote:
> 
> 
> On 7/11/23 12:43, Li zeming wrote:
> > err is assigned first, so it does not need to initialize the assignment.
> > 
> > Signed-off-by: Li zeming <zeming@nfschina.com>
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks, I've taken this through the modules tree and pushed out.

  Luis
