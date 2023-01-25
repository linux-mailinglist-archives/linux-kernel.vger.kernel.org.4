Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F6E67B877
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbjAYRXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbjAYRXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:23:41 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C9F5C0FC;
        Wed, 25 Jan 2023 09:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1674667382; bh=RyDTlzZ7J1y305xWPRZw5jruHPoo4gvTvMQCnixJLR0=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=TUAqewYij+dtOlSbbJe7CrNmIBVFnj26s+S+FLzM1FY1j2BF/o9Uhso3eG+7wSnsx
         cTgOHStWbHvGa55y48lMks1CSbZaIpVQuegcJhpvkhgVNYWfWiFGHxlBnHQ82Pbhpn
         piKkt6ZXMAahs7rRUY4n2Fo9bXL/gEFOwBaPxLCg=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Wed, 25 Jan 2023 18:23:02 +0100 (CET)
X-EA-Auth: HQuo9TwHAXidIJHtCp9wA/lPloIDL12a5h9SO3eXjXRuNFKy3FguTuIATyAlgLErKwQLtyIIJXnskMU0adMhtDqrRzGfY5kG
Date:   Wed, 25 Jan 2023 22:52:56 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH] scsi: qla2xxx: Use a variable instead of repeated
 computations
Message-ID: <Y9FlcO54LWVYRuGm@ubun2204.myguest.virtualbox.org>
References: <Y9FdOu4Y3KS5eVUf@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9FdOu4Y3KS5eVUf@ubun2204.myguest.virtualbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 10:17:54PM +0530, Deepak R Varma wrote:
> Use a variable to upfront compute memory size to be allocated, instead
> of repeatedly computing it at different instructions.  The reduced
> length of lines also allows to tidy up the code.
> Issue identified using the array_size_dup Coccinelle semantic patch.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---

Please ignore this duplicate patch. I got this from a wrong/old branch. My
apologies for the inconvenience.

./drv


