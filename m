Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CC47231AE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 22:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjFEUqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 16:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjFEUqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 16:46:01 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F21A7;
        Mon,  5 Jun 2023 13:46:00 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 355KjqYO042200;
        Mon, 5 Jun 2023 15:45:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685997953;
        bh=IM26LQhhxQAXSh7/HG0igDymrTDNSeNiHL1OIbK2lec=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=FXvkd2Nq0pyh3Yv0K3TE9KIC5kmP1Gv7IbkN/jDBIRIJlJKeWbRkiDJccPeMXSfQ1
         CeQyF5Vd6pIWIvNpAy4wwYJbYRwzOxtKDcpT+YuMYRkBdZlFdzbsxYIXPQfRTt+1bO
         hx5ICN6qZQ7GL5MKlWkGNeHLuSG/qIiiUA/BL9tY=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 355KjqtU001866
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Jun 2023 15:45:52 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Jun 2023 15:45:52 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Jun 2023 15:45:52 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 355Kjqkk104642;
        Mon, 5 Jun 2023 15:45:52 -0500
Date:   Mon, 5 Jun 2023 15:45:52 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     MD Danish Anwar <danishanwar@ti.com>,
        Bjorn Andersson <andersson@kernel.org>, <rogerq@kernel.org>,
        <vigneshr@ti.org>, <srk@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] remoteproc: pru: add support for configuring GPMUX based
 on client setup
Message-ID: <20230605204552.x4ctuzos4rysldwj@sessions>
References: <20230601105904.3204260-1-danishanwar@ti.com>
 <ZH4aywQoA9gy2OWU@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZH4aywQoA9gy2OWU@p14s>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:26-20230605, Mathieu Poirier wrote:
[...]
> Here I have to suppose pruss_cfg_get_gpmux() has been added to Nishanth's tree.
> As such the only way for me to apply your patch is if Nishanth sends me a pull
> request for the patchset that introduced pruss_cfg_get_gpmux().  You can also
> resend this in the next cycle.

Yes, I had pulled this in [1] along with a few other driver fixes. I
can send you an immutable tag to pull for your tree, if that helps the
process along though, it might have a unrelated driver fixup patch as
part of the series though..

[1] https://lore.kernel.org/all/168434617580.1538524.11482827517408254591.b4-ty@ti.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git/log/?h=ti-drivers-soc-next
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
