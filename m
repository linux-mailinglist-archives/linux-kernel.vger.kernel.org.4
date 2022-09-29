Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866E25EFDBF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 21:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiI2TQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 15:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiI2TP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 15:15:57 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CDB7D79B;
        Thu, 29 Sep 2022 12:15:52 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BE649734;
        Thu, 29 Sep 2022 19:15:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BE649734
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1664478951; bh=wVxyf+9BPs/yBWBV/7x6qgt0i/r3QzA8XI2jiuPRPSw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Q0ho4IzsxtmI8epHHm7NF1Mohl8GDIlnZGBccUswFuiZ6Mlph+PoG4Lr3XuJP4iHp
         7SJ6VGYLAIsCNAmCuyDchzLdvYFrS4z5INUK0YFVmwTqRXfGc/M3UwZ2JIbUIhqaMK
         KIgsOAv4NKE6IbbOjas1oYSV2aC0bnUASkj00f2eq5ZGTNCPXaVfRzCh7aP9sJD7Fi
         0PMLz4RTK6et+j8looLrCMOTWIJQHdQrB+Jqa/TRES+lOQw2uZJfBR1DdFL7TFq79y
         R4oc0UrTU9A/HP9PiL8Ynpql0fjtTkdl2HZLBiCwJgIqR9tIuGoLAlf/M0gGqYz4Lp
         Co0fsSflDaE+g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/CoC: Reflect current CoC interpretation
 and practices
In-Reply-To: <20220926211149.2278214-1-kristen@linux.intel.com>
References: <20220926211149.2278214-1-kristen@linux.intel.com>
Date:   Thu, 29 Sep 2022 13:15:51 -0600
Message-ID: <871qruhtzs.fsf@meer.lwn.net>
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

Kristen Carlson Accardi <kristen@linux.intel.com> writes:

> The Code of Conduct interpretation does not reflect the current
> practices of the CoC committee or the TAB. Update the documentation
> to remove references to initial committees and boot strap periods
> since it is past that time, and note that the this document
> does serve as the documentation for the CoC committee processes.
>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  .../code-of-conduct-interpretation.rst        | 24 ++++++++++---------
>  1 file changed, 13 insertions(+), 11 deletions(-)

I've applied this, thanks.

jon
