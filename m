Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835C662E756
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240908AbiKQVzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240859AbiKQVy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:54:58 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18BA6C726
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:54:57 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id l14so6151253wrw.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qEXceOMwPaSIJx/8No20TDoKwj2aKK6U1O1wHH+N2TE=;
        b=P1wR/4Jtcs7437jG8nfedVkakwQ2sKxrKpdj6cuPyflcc+siqOjsRMD1tITIhiVudD
         N2PhHk1c99ZB5GjOmyRPMB49+//DEj373bjN7Mxo0rwjOaIGv+/ezPHF0x1HnW5KmgL1
         0bvk0pQ9+SLf3zWWdJDpnHQeE7XBKQ+rUJXolGWqjzRVxLEJxKgk2Iziby8F/ELPFN9g
         /W7CC43inhKwLGAMZrXANw28dwtP982wA+dbOFBWt8cyhdg0NTAL7O0VFwaQu822e7fw
         6zdg0S0+fWVURuF+hdJKHtaE2dJchECYE/aWM5rd3Ihin68PjahkUyQrxHIwYO7pktBi
         f7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEXceOMwPaSIJx/8No20TDoKwj2aKK6U1O1wHH+N2TE=;
        b=8OtS22f6nCytjImD/v9zA7ySeT2HOgALsP7XMlmbetwG9CW0EX8naq705EFbzMJela
         9jFo0GHzyBUe8KfRLJkT7bBiQobrSBpd78Ag7b7whKQqzou+/8pWIQD7KFoH71Fmmf1L
         iNp0wrA2HWABmAwl10l7CgIu83PwBeAER3waKy8/KhjtBUDKvJijx8FMOQcrJZo9nxwb
         07VnNbQswzkpJ12PL//MnPtG5GmHBj6ulH83hok0mNJyUmE5xG2Ri+3PCkishGmdYNNb
         WpfIuIa4Tn9c+U4jMe/LHuHgm01bwbOgjZWOX4V7BeTxyGBk315M80zATgDKSgT6tlkC
         YCUg==
X-Gm-Message-State: ANoB5pkZow5q4GC/0ydpjq07WIe7M6TVfHv0JZyZVsXeNb8W9UJNzUGS
        gOI5ZPQ08VM2n4rDXL2Rf7ibLbSa/8ikHFFCbJg=
X-Google-Smtp-Source: AA0mqf4e0alPCK9TBY8I86zASGDY9ceN1l7Zi3Cq+IsXLmNV3NSKyN9GAU71Efz9Sq8meJEozonIKB2Jgd2cGd/4ms4=
X-Received: by 2002:a5d:5385:0:b0:241:beff:257a with SMTP id
 d5-20020a5d5385000000b00241beff257amr737073wrv.656.1668722096267; Thu, 17 Nov
 2022 13:54:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:adf:f1c3:0:0:0:0:0 with HTTP; Thu, 17 Nov 2022 13:54:55
 -0800 (PST)
Reply-To: terryedwardbarwick@gmail.com
From:   Terry Edward Barwick <luccaromeo832@gmail.com>
Date:   Thu, 17 Nov 2022 13:54:55 -0800
Message-ID: <CAFzAf6o938z5ZtXw+e6m+ymE3onpwOmSDZe1__krBuVduFMm4w@mail.gmail.com>
Subject: =?UTF-8?B?16nXnNeV150s?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=3.9 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16nXnNeV150sDQoNCg0KICAgICAgINep157XmSDXmNeo15kg15DXk9eV15DXqNeTINeR15DXqNeV
15XXmdenLiDXoteVIteTINec16LXoNeZ15nXoNeZINee16nXpNeYINeV157XqdeQ15HXmSDXkNeg
15XXqQ0K16LXldeo15og15PXmdeg15Ug16nXnCDXkNeZ16DXkicg15Yi15wuINeQ15zXodeg15PX
qNeVINep15TXmdeUINen15HXnNefINeR16DXmdeZ158g15ENCteT15XXkdeQ15ksINeQ15nXl9eV
15Mg15TXkNee15nXqNeV15nXldeqINeU16LXqNeR15nXldeqLiDXnNee16jXqdeZINeU15nXlCDX
nNek16DXmSDXnteV16rXlQ0K15nXqteo15Qg157Xldei16jXm9eqINeR15fXqdeR15XXnw0KKDUu
NyDXnteZ15zXmdeV158g15PXldec16gpINeR15HXoNenINeb15DXnyDXkdeQ15nXl9eV15Mg15TX
kNee15nXqNeV15nXldeqINeU16LXqNeR15nXldeqDQrXlNeQ157Xmdeo15XXmdeV16og15TXldek
16fXk9eVDQrXnteQ15XXl9eTLiDXkNeg15kg15nXldem16gg15DXmdeq15og16fXqdeoINeb15PX
mSDXnNeU15nXqdeQ16gNCteb157XldeY15Eg15fXlden15kg16nXmdep15zXnteVINec15og15DX
qiDXlNeb16HXpNeZ150NCteZ15vXldecINec15TXmdeV16og15UNCtee16nXldeq16Mg15HXmdef
INep16DXmdeg15UuDQoNCiAgICAgICDXkNeV15PXlCDXnNeq16nXldeR16rXmiDXlNee15TXmdeo
15QuINeq15fXlteV16gg15DXnNeZDQrXkNeg15kg15nXm9eV15wg15zXlNeh15HXmdeoINeZ15XX
qteoINei15wg15TXoNeV16nXkCDXlNeW15Qg15XXkNeZ15og15zXlNee16nXmdeaLg0KDQoNCiAg
ICAgICDXnta315fWstee1rjXkNa415QNCg0KICAgICAgINee1rfXqC4g15jXqNeZINeQ15PXldeQ
16jXkyDXkdeQ16jXldeV15nXpy4NCteT15XXkCLXnDogd3d3LnRlcnJ5ZWR3YXJkYmFyd2lja0Bn
bWFpbC5jb20NCg==
