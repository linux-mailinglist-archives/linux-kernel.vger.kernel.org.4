Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1B3636608
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 17:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239128AbiKWQnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 11:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239067AbiKWQnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 11:43:47 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9303686B6;
        Wed, 23 Nov 2022 08:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1669221822;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=NA2R0Q9HxadI+SwNbciamrN8wAJ3LMmpSYptqo2sCSQ=;
    b=dxSIgxDzsom1t0LODeJQanT4eTq4BRKxWlvrvgwcF2oDkrnAcTWIXQSuniVhJ8ePw7
    ZPYRCIp+1tSHVoDTnpWI4sdi+hAj5xycpfC/wnQxtEI50jFpf5xQTmYHZ11wCT7RbkHH
    Wd+1QphJj20DnmltFOu+brdazbSd5gBD5ITSrow+iQPrhxn7eGvRxhhCtzvIT/bm2Lik
    iCTR0LvtQ6+kvDexANJ4jPr537sPVmbmjKwu+qma0d8EoGgxlwbKjlL/PDGjbTBgQl5z
    md3trpsaaeKbtc2m9UFh+vyvAyZTFhc5tlmK4neAXc+5TJzeYtI3mLNB648PZU7nqu5v
    kMbQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSeBwhhSxarlUcu05JCAPyj3VPAceccYJs0uz"
X-RZG-CLASS-ID: mo00
Received: from blinux
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id z9cfbfyANGhgnDi
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 23 Nov 2022 17:43:42 +0100 (CET)
Message-ID: <3c3563349b6d85a8e5f4af8c3443499c8bfcb06c.camel@iokpp.de>
Subject: Re: [PATCH v3 1/4] ufs: core: Remove redundant wb check
From:   Bean Huo <beanhuo@iokpp.de>
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 23 Nov 2022 17:43:41 +0100
In-Reply-To: <1669045590-26101-2-git-send-email-Arthur.Simchaev@wdc.com>
References: <1669045590-26101-1-git-send-email-Arthur.Simchaev@wdc.com>
         <1669045590-26101-2-git-send-email-Arthur.Simchaev@wdc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-11-21 at 17:46 +0200, Arthur Simchaev wrote:
> We used to use the extended-feature field in the device descriptor,
> 
> as an indication that the device supports ufs2.2 or later.
> 
> Remove that as this check is specifically done few lines above.
> 
> 
> 
> Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>

Reviewed-by: Bean Huo <beanhuo@micron.com>



