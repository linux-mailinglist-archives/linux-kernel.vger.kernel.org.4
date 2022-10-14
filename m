Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2A75FEFAC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 16:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiJNOER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 10:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiJNODh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 10:03:37 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9CC1D20D1;
        Fri, 14 Oct 2022 07:02:51 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6F09E35D;
        Fri, 14 Oct 2022 14:01:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6F09E35D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1665756119; bh=gbZzFGi0DSyuETMCUk6reDBoaJz8+cLXjDxO5eRHjvE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=S9xOMx/OZvcRHXLRWB1Ul+0vAzTIoES49Je91LcmW/7V7XADM88FjzNKdj+1zQzcB
         /vUe2kJ+uiDkm0fF/6p0nZsNNnlSckeKEwJMI1oo1zhluZjZOxpfeXAPNVDg8rLHDS
         T7NvFZZbSAcfEqYQi6ltrM24GmE55c3F76/azxznkBvJj7IajG7WWWlBHlrrVdJehl
         /poKARtHRY0QaqmD9vnJPV60iQWhf6gZ2wjCt+067cYj2eLVlp+SIf8SIbibtYuUSj
         velU80CDYX2N4GZy142jeOWgl0gqVxwVzH0X5TCo/JFQTALaWH6RzQTCDikstqhimK
         PVlZsleK+ZY3g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jason Wang <jasowang@redhat.com>, mst@redhat.com,
        jasowang@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        mikelley@microsoft.com, vkuznets@redhat.com, liuwe@microsoft.com,
        kkashanjat@microsoft.com, cohuck@redhat.com, otubo@redhat.com,
        andavis@redhat.com, aadam@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: Re: [RFC PATCH] virtio: document virtio hardening status and TODO
In-Reply-To: <20221014042037.23639-1-jasowang@redhat.com>
References: <20221014042037.23639-1-jasowang@redhat.com>
Date:   Fri, 14 Oct 2022 08:01:58 -0600
Message-ID: <87o7ueh5bd.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Wang <jasowang@redhat.com> writes:

> This patch summarizes the status of hardening and TODO of hardening
> virtio core and drivers.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  Documentation/security/virtio/core.rst | 49 ++++++++++++++++++++++++++
>  MAINTAINERS                            |  1 +
>  2 files changed, 50 insertions(+)
>  create mode 100644 Documentation/security/virtio/core.rst

Do you really need to create a new directory for a single file?

Regardless of where it sits, you'll need to add this file to an
index.rst file so that it becomes part of the docs build.

Thanks,

jon
