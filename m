Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8C55F4996
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 21:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiJDTI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 15:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJDTI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 15:08:56 -0400
X-Greylist: delayed 484 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Oct 2022 12:08:55 PDT
Received: from mx.cjr.nz (mx.cjr.nz [51.158.111.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768E2558E0;
        Tue,  4 Oct 2022 12:08:55 -0700 (PDT)
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id CAACC8079F;
        Tue,  4 Oct 2022 18:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1664909946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=myIGBnfBacIG2+HWik5iZ7600MHQKUlDlQPLoFbcxX8=;
        b=Z+jJ47GsoCRk3wbcpVcQrV8XfZWlkR8lL3oB+/fogM5z1dR3mNRIGwP6ReWz4Lk0YeX36e
        oGdtEMAT8m0M6/KP5Eauwre+fIEIQy7QlUOqvW0PnlZU0P+sIYADe+5Ww2ypWiMEIdeLFc
        HfJPAl6ItKbFOw2BLBfqyDCRVhtVonxNbHSdqyZA115hohF29tSGJgiaiXgSd9CU678qUs
        a4G8tdM2eaNljBM+NjnoW4vpJFVt8snRqpZ2Mqx4pfoJ+UCGk0agmC+MaITtN2QRuWA7dn
        vOZZqOBdquVN5yEHr5AF3Un+bhHl1GbTIMdqC4QECmYOhknIIypGzvL6CUzzTg==
From:   Paulo Alcantara <pc@cjr.nz>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Steve French <sfrench@samba.org>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, kernel-janitors@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cifs: remove initialization value
In-Reply-To: <20221004062333.416225-1-usama.anjum@collabora.com>
References: <20221004062333.416225-1-usama.anjum@collabora.com>
Date:   Tue, 04 Oct 2022 15:59:55 -0300
Message-ID: <87o7ur4dp0.fsf@cjr.nz>
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

Muhammad Usama Anjum <usama.anjum@collabora.com> writes:

> Don't initialize the rc as its value is being overwritten before its
> use.
>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  fs/cifs/smb2pdu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
