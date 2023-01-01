Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921B665AAAB
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 17:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjAAQcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 11:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjAAQcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 11:32:02 -0500
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4D210F1;
        Sun,  1 Jan 2023 08:31:53 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id 530A1205F;
        Sun,  1 Jan 2023 17:31:52 +0100 (CET)
Authentication-Results: ext-mx-out001.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        in-reply-to:content-transfer-encoding:content-disposition
        :content-type:content-type:mime-version:references:message-id
        :subject:subject:from:from:date:date:received:received:received;
         s=dkim20160331; t=1672590709; x=1674405110; bh=Nz3RSw9KzQ8ZPUCr
        19SSKcnuLUMLZ+33WX+06j/aqpY=; b=Ijt6ezLMqyHIpVuQCXSUTFLm+blNW4Z8
        pCpi9K8FQWy67rc/rbKXsQYH1b1BWGa8iAPCno+nsOqrqoUc0nCmRLNhAZWI3VUq
        obO8jslJeWEcI+bptW1wk/Pz64Kl5Xh1C4wooqbC3SotAJeqLxQ9rGbdW3ujELak
        78Lg5VRcSlHgC1JoKZvawCXHRd//KBTL5SA4+gPTzm7hizPWJ3hX47ACDt/9QOen
        VyLssRdcJf4rteUSuQExBUv1MOJRhJSG/QYYMMDbvxEsUzf/of+XF50g+M3iq+OO
        fgsVA6uSFfd3PL4QhI+wPQrVjYsxnBU99ZLz5P54IVW9kEY2TQNHWX/aHYMVWin/
        crV/wnwdNS6Au0Hk5X92lj2Elyurnf6FDWGRLDO5tRkQphaMaKdKaEDLGaNg4ySs
        PCtNZDUFsUEkWEggtJUIsAfg2yi7Ny5wpBMoH9E4fEVlERr7B8TbNuQNA3xqGyCa
        nJ9xWrRq2LAXbpJ6uLWNJ3UCuJd7XAOLabuAmP/lFbjAQgm6P0A5FnixH6FZZC2M
        Mystn+exEW4jtDqAIahVozhruvEersDVz3iBdFsry929oqBa1pmPB4CGt07KZbWD
        BgN3TIn3XITIjns3XwDIxTZOoeiY0ejfJ7pCvlBIy4iRR2apK2JrBUswh8Y85LwF
        ZnK8Et6ZBsg=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WMNRh7r77fTi; Sun,  1 Jan 2023 17:31:49 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by mx.kolabnow.com (Postfix) with ESMTPS id 4DEB4205C;
        Sun,  1 Jan 2023 17:31:48 +0100 (CET)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 0A9DF2FC1;
        Sun,  1 Jan 2023 17:31:47 +0100 (CET)
Date:   Sun, 1 Jan 2023 17:31:45 +0100
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Fabio Fantoni <fantonifabio@tiscali.it>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc:it_IT: fix of 2 typos
Message-ID: <20230101163145.nliposfmaf2it3mc@numero-86.vaga.pv.it>
References: <20230101155548.12350-1-fantonifabio@tiscali.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230101155548.12350-1-fantonifabio@tiscali.it>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 01, 2023 at 04:55:48PM +0100, Fabio Fantoni wrote:
>Fix of 2 typos spotted reading documentation in italian
>
>Signed-off-by: Fabio Fantoni <fantonifabio@tiscali.it>

Acked-by: Federico Vaga <federico.vaga@vaga.pv.it>

Thanks

>---
> .../translations/it_IT/process/maintainer-pgp-guide.rst         | 2 +-
> Documentation/translations/it_IT/process/submitting-patches.rst | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst b/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst
>index a1e98ec9532e..37a8ecb00af2 100644
>--- a/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst
>+++ b/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst
>@@ -163,7 +163,7 @@ chiave principale attraverso firme certificate. È quindi importante
> comprendere i seguenti punti:
>
> 1. Non ci sono differenze tecniche tra la chiave principale e la sottochiave.
>-2. In fesa di creazione, assegniamo limitazioni funzionali ad ogni chiave
>+2. In fase di creazione, assegniamo limitazioni funzionali ad ogni chiave
>    assegnando capacità specifiche.
> 3. Una chiave PGP può avere 4 capacità:
>
>diff --git a/Documentation/translations/it_IT/process/submitting-patches.rst b/Documentation/translations/it_IT/process/submitting-patches.rst
>index a3bb0008837a..c2cfa0948b2b 100644
>--- a/Documentation/translations/it_IT/process/submitting-patches.rst
>+++ b/Documentation/translations/it_IT/process/submitting-patches.rst
>@@ -340,7 +340,7 @@ Assicuratevi di dire ai revisori quali cambiamenti state facendo e di
> ringraziarli per il loro tempo.  Revisionare codice è un lavoro faticoso e che
> richiede molto tempo, e a volte i revisori diventano burberi. Tuttavia, anche in
> questo caso, rispondete con educazione e concentratevi sul problema che hanno
>-evidenziato. Quando inviate una version successiva ricordatevi di aggiungere un
>+evidenziato. Quando inviate una versione successiva ricordatevi di aggiungere un
> ``patch changelog`` alla email di intestazione o ad ogni singola patch spiegando
> le differenze rispetto a sottomissioni precedenti (vedere
> :ref:`it_the_canonical_patch_format`).
>-- 
>2.25.1
>

-- 
Federico Vaga
