Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F68268D163
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 09:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjBGITs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 03:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBGITj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 03:19:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E5728D0A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 00:19:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 531EFB816DD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 08:19:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4031DC433D2;
        Tue,  7 Feb 2023 08:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675757975;
        bh=vJgMpS9BkR0EfmTP8rJ6hiNKNfn+Wvppol+zFcudNjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=azsFIZORdLTIi01sODH3TJsWoZEhInLA7Gcwi4Fp8dvwSm8jom9jfUBZLr+IdgU87
         ul7itFR8J5mg3YYfG/zkWURC0m80n6rOdjfHa3CHrL6qnnFqGb/8dmboofcNf/Cm1v
         HlwmZCOO0N87Gqww0qBa+hcUlv9+9sqEeam2B1mIDqmDUTlmVA63R70+QAAeVRUwyC
         cXtphz7B87F8MvXMcqz5AHD90DUBngYAbf530B+vdsOTaG+NABCQ2L7IzOQC9ufevs
         T3nGTeDLpgHQ6nvRcN9gjpj22Z/dydkALY355QI75qmzVzR0gRztWBMwXa+Bx3YCiz
         pj5HQLJUiUBdw==
Date:   Tue, 7 Feb 2023 09:19:29 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, ebiederm@xmission.com,
        torvalds@linux-foundation.org, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 0/8] Use copy_process in vhost layer
Message-ID: <20230207081929.qnn6qbtvfmksnvm2@wittgenstein>
References: <20230202232517.8695-1-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230202232517.8695-1-michael.christie@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 05:25:09PM -0600, Mike Christie wrote:
> The following patches were made over Linus's tree. They allow the vhost
> layer to use copy_process instead of using workqueue_structs to create
> worker threads for VM's devices.

Thanks for keeping at this, Mike.
I can pick this up once you resend with the requested changes.
