Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EE668D497
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjBGKlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjBGKlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:41:11 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CE939BB3;
        Tue,  7 Feb 2023 02:40:47 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 12BE5660206C;
        Tue,  7 Feb 2023 10:40:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675766425;
        bh=aDe3YXnfUuI58uMCtTnI5EYyG01HWAiAlxrcCdAqU/8=;
        h=From:To:Cc:Subject:Date:From;
        b=BO3m3ePFlJpU1ibDl7kKm0IDoKD2o5r/gWKReuFDE01gmLZSfN8mvdyA7nR73yIjg
         yaF3wPaZnu5xqCVg1EkTfbHIxr1O+wG4XDWQ17t1F5DL/PkRVUz8exsqMXFzq/I0Mw
         BuW51IXF5xZnfkJeQ8N+oNOMGTmguHXWpVFcXqgjLXSZIpchbz/5P4fdgZkva5OKjt
         DF9HhQsb2ql3vN5IGHV3tU2DITNWuexIrVq1hM8QH4rAxHCPtSf9J7VFCv/X23exps
         TDMO9HZGw5ZR4301YPs+vgEm21LYPe0MUskJ5qj7JeYvx3iqSUulkkP+Weh9RstHeF
         HXouKwEqJdzrQ==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     David Rhodes <david.rhodes@cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Lucas Tanure <lucas.tanure@collabora.com>
Subject: [PATCH 0/2] Add CS35L41 shared boost feature
Date:   Tue,  7 Feb 2023 10:40:19 +0000
Message-Id: <20230207104021.2842-1-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Valve's Steam Deck uses CS35L41 in shared boost mode,
where both speakers share the boost circuit.
Add this support in the shared lib, but for now,
shared boost is not supported in HDA systems as
would require BIOS changes.

Lucas Tanure (2):
  ALSA: cs35l41: Add shared boost feature
  Documentation: cs35l41: Shared boost properties

 .../bindings/sound/cirrus,cs35l41.yaml        | 11 +++-
 include/sound/cs35l41.h                       | 10 +++-
 sound/pci/hda/cs35l41_hda.c                   |  6 +-
 sound/soc/codecs/cs35l41-lib.c                | 56 ++++++++++++++++++-
 sound/soc/codecs/cs35l41.c                    | 21 ++++++-
 sound/soc/codecs/cs35l41.h                    |  1 +
 6 files changed, 97 insertions(+), 8 deletions(-)

-- 
2.39.1

