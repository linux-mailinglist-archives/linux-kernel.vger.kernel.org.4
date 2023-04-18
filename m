Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104196E5C4B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjDRIjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjDRIjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:39:36 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655DC72B9;
        Tue, 18 Apr 2023 01:39:12 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I50ujp014943;
        Tue, 18 Apr 2023 03:38:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=QIGOwCnoD9saG41Ua74ZCdSTXr1oUGK7HY9sOWvvMSg=;
 b=O1uzvMyS9wYrgoEollZhxJd4gzViZuXEz/l01QmpxK3VoVfzGVW1rxKEc707uiqAhk4B
 bhrD0UFfP9l0WRNLgHDD1PDwl7krW/dOLXz2fLKfXf9ahKzLoYgrU2FxQsvRnGDV2xn0
 dcFLk2ZCzS7yzjds5gjDC0Le8xNaIGhTEQKBk4ypaBcxdLsuPd7QPgr5v8dGQ7cXQ6O7
 DzSjMrXZT9pksHxG0yDZKS8XO7PEP7E3655AXlwMQSHHb16a/FA3bQNelerU9x09Z7el
 nnfglIRePSH/bEzlV3sZECNOmu+m7eONvowFawZUvcL58XETDtR3+Q144hVhEejYnEUU 1Q== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pyrbpwuk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 03:38:31 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 18 Apr
 2023 03:38:30 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 18 Apr 2023 03:38:30 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E959445D;
        Tue, 18 Apr 2023 08:38:29 +0000 (UTC)
Date:   Tue, 18 Apr 2023 08:38:29 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Saalim Quadri <danascape@gmail.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <daniel.baluta@gmail.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: wm8728: Convert to dtschema
Message-ID: <20230418083829.GA68926@ediswmail.ad.cirrus.com>
References: <20230417204323.137681-1-danascape@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230417204323.137681-1-danascape@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: 1_gKeb4A7u8aGsCnr1sCts4zPnKAP3QN
X-Proofpoint-ORIG-GUID: 1_gKeb4A7u8aGsCnr1sCts4zPnKAP3QN
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 08:43:23PM +0000, Saalim Quadri wrote:
> Convert the WM8728 audio CODEC bindings to DT schema
> 
> Signed-off-by: Saalim Quadri <danascape@gmail.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
