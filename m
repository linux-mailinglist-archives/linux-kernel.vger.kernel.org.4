Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041F1659AF2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 18:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbiL3RZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 12:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiL3RZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 12:25:10 -0500
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB23FCCB;
        Fri, 30 Dec 2022 09:25:09 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id 10AD241947;
        Fri, 30 Dec 2022 18:25:08 +0100 (CET)
Authentication-Results: ext-mx-out003.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:message-id:date:date
        :subject:subject:from:from:received:received:received; s=
        dkim20160331; t=1672421105; x=1674235506; bh=EX2hFxOy5ZrIa6WgZiW
        R43zhUPynZA0prUHu1Ng0l2M=; b=t76I3YVD+I7RSxqPK03c8+MWwuI8BwVTXbY
        JEpIU2svOkgWb7bWHgcyc6BR8d0Xu1WwLcpr1+aiP8iEOdKzvjMgb3ebsrypFsuC
        uJmZKoZcZe9H+pa2vxftf75PIi3GYvLug4ugrOC+sqFH8gQDEPxv8dFxbPKQAIdf
        fuvKu6l3Bq84zU4QVRQxlt5YxTS182TApXrvvAgWw7tdoGMSTJ+lOYeixIBfZBMf
        N8NTjsk1OxImMMe8dix7ZCJgFW4In6Wk3cdj7xljMI9w7mLmsUa7+/uvtECJ8Qdh
        4OOOrwCJyq36BFH79RvSVJYr01QOFhg0ua8E61eiNlz+EmT20fiK22d4aeLSSNOM
        jrB0CdN6GNMMbO2C/YWrBLLGmGiUCx03P4WFAPODZVVKMjUOVVNoXDOffkfPb/8h
        7/37/prpe4cLuJzJQIYADpXN6asMh0dqzZdcnLOLh0giYxEqEXDJ75Qw8utpEuta
        FmqAA0MO/3FEKE/rHoIkD0g+yQIozRZmnZ7gIUJqoc0s3sThjqV8wbsSZ7JEUL0X
        JpPSS4Mp/Z8lCWazHwMZ9fysMAfYlnjRBkUSXWywDd5s/Ke8vaOUzD90RJHMsT39
        wSFeJktH9JzYvJ1P3BK9S21O1VwmquegzoCHNOm1Sk2TwtI0NVaIUkZWNCbb2j2N
        gjrXCgxI=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id o3MWqmr-Vcxa; Fri, 30 Dec 2022 18:25:05 +0100 (CET)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by mx.kolabnow.com (Postfix) with ESMTPS id 4EF5B4193F;
        Fri, 30 Dec 2022 18:25:05 +0100 (CET)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 062822467;
        Fri, 30 Dec 2022 18:25:05 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] doc:it_IT: fix typo in email-client
Date:   Fri, 30 Dec 2022 18:24:56 +0100
Message-Id: <20221230172456.58745-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`usato` becomes `usando`

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/translations/it_IT/process/email-clients.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/it_IT/process/email-clients.rst b/Documentation/translations/it_IT/process/email-clients.rst
index de7d32f78246..b792f2f06a74 100644
--- a/Documentation/translations/it_IT/process/email-clients.rst
+++ b/Documentation/translations/it_IT/process/email-clients.rst
@@ -106,7 +106,7 @@ Funziona. Alcune persone riescono ad usarlo con successo per inviare le patch.
 Per inserire una patch usate :menuselection:`Messaggio-->Inserisci file`
 (:kbd:`CTRL-I`) oppure un editor esterno.
 
-Se la patch che avete inserito dev'essere modificata usato la finestra di
+Se la patch che avete inserito dev'essere modificata usando la finestra di
 scrittura di Claws, allora assicuratevi che l'"auto-interruzione" sia
 disabilitata :menuselection:`Configurazione-->Preferenze-->Composizione-->Interruzione riga`.
 
-- 
2.30.2

