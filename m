Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DB66661F8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 18:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbjAKRbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 12:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbjAKR3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 12:29:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73C234768;
        Wed, 11 Jan 2023 09:29:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82EE661DB1;
        Wed, 11 Jan 2023 17:29:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20FDC433EF;
        Wed, 11 Jan 2023 17:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673458150;
        bh=y39PE6M+8ksX7feTgJtDzezm8DMAUsa4opQKPTygkLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fgFOenQeZ6yZWJQ/Ze6hGGBqwSL+YxXrIZlnQjx9/WLtHUTh8RPIRfAt7Pzdio8vJ
         zyentmFWHqQMBdcFHHj3z9yQEMnwO/nyu+D+yfM9wkYMMrzZxN3KGwPsp1DuKrPb2L
         b4BkKXxF9GzwWtB6lWAca35Cgu9U0SdfaaoaCX2057g1SOKMjoPDpI3/gR1lLlaHtH
         DGFzpmYva4b1G1nJisRjOnx5CgVMLNd364+YhWjgrkXI2SqrCOBM+4WcVDcvCRtKG7
         um+aWplx5+YbjBka/k7VFrrAHOYy+LCjp+Hp20mbDSPXzKs5mbJDK8EbUaeN/NcGfx
         p3zan5eU5J9ow==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pFeuV-0004C0-UL; Wed, 11 Jan 2023 18:29:11 +0100
Date:   Wed, 11 Jan 2023 18:29:11 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Samuel Iglesias =?utf-8?Q?Gons=C3=A1lvez?= 
        <siglesias@igalia.com>, Rodolfo Giometti <giometti@enneenne.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/13] tty: Return bool from tty_termios_hw_change()
Message-ID: <Y77x5/lpK0OJB0eT@hovoldconsulting.com>
References: <20230111142331.34518-1-ilpo.jarvinen@linux.intel.com>
 <20230111142331.34518-11-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230111142331.34518-11-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 04:23:28PM +0200, Ilpo Järvinen wrote:
> Change tty_termios_hw_change() to return bool.
> 
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Johan Hovold <johan@kernel.org>
