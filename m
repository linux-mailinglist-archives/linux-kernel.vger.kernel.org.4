Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC1C620978
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 07:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbiKHGTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 01:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbiKHGTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 01:19:24 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C9C40914
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 22:19:13 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221108061911epoutp0127164e692d86ab80b1b489c2f1038ee8~lh55p7Xg72065820658epoutp01X
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 06:19:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221108061911epoutp0127164e692d86ab80b1b489c2f1038ee8~lh55p7Xg72065820658epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667888351;
        bh=JgKzig38qBrtQAtx+eWII8EH9dq8ZbtAlbZW5GDHrdQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=DaPd1WHQh7SnTdfMNpzp6+OrwcOJhF70UUjVWoGrgVLcRB2ZMToKSF+ub0FS+Jjnw
         az4k0RAmk7TT/jEuef8862eR4JHQUrnzdiT763gsnHDnzx+3JjE97bttDOri2PcU3r
         FzD9dxDZG2+OBeCnD8W7bYpVTZr8eZIhESNjNRHI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221108061910epcas5p351671cdad900c5cac6ef90d951c8ce9c~lh541L3_q0649206492epcas5p3G;
        Tue,  8 Nov 2022 06:19:10 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4N5ybw18ysz4x9Q0; Tue,  8 Nov
        2022 06:19:08 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5E.7C.01710.CD4F9636; Tue,  8 Nov 2022 15:19:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221108053359epcas5p2f95f5a32b2193759f39dbb51759850e6~lhScEu_E31214812148epcas5p2P;
        Tue,  8 Nov 2022 05:33:59 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221108053359epsmtrp12d52f4cb42e57124ebe3e475910a5c1f~lhScDGR8S2724627246epsmtrp1-;
        Tue,  8 Nov 2022 05:33:59 +0000 (GMT)
X-AuditID: b6c32a49-c9ffa700000006ae-49-6369f4dcabfb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.80.18644.74AE9636; Tue,  8 Nov 2022 14:33:59 +0900 (KST)
Received: from FDSFTE070 (unknown [107.116.189.86]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221108053357epsmtip26a0da1b742fb5ff7930d771862370397~lhSZ6NTmr2616526165epsmtip2R;
        Tue,  8 Nov 2022 05:33:57 +0000 (GMT)
From:   "Padmanabhan Rajanbabu" <p.rajanbabu@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Rob Herring'" <robh@kernel.org>
Cc:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s.nawrocki@samsung.com>,
        <perex@perex.cz>, <tiwai@suse.com>, <pankaj.dubey@samsung.com>,
        <alim.akhtar@samsung.com>, <rcsekar@samsung.com>,
        <aswani.reddy@samsung.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <253fc459-c3dc-7710-6f34-0466d5301482@linaro.org>
Subject: RE: [PATCH 3/6] dt-bindings: sound: Add sound card bindings for
 Tesla FSD
Date:   Tue, 8 Nov 2022 11:03:55 +0530
Message-ID: <01c101d8f333$b3bc8db0$1b35a910$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKFI9qd/qMOsyXBjKz4d8Q6MS4QvwIZxyFGAJxV9qUBrWX0bwKccdsCAkaHXJeskenVEA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBJsWRmVeSWpSXmKPExsWy7bCmuu6dL5nJBt92sVk8mLeNzeLKxUNM
        Foc2b2W3mPrwCZvF/CPnWC36Xjxkttj7Gij27UoHk8XlXXPYLGac38dksWjrF3aLzl39rBaz
        Luxgtfi/Zwe7xeE37awWG76vZXQQ8NjwuYnNY+esu+wem1Z1snncubaHzWPf22VsHn1bVjF6
        rN9ylcXj8ya5AI6obJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUX
        nwBdt8wcoBeUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQUmBXrFibnFpXnpenmp
        JVaGBgZGpkCFCdkZE7q2Mxb0uld0fWpha2B8ZNbFyMkhIWAicejzCfYuRi4OIYHdjBI9z1pY
        IJxPjBKr3r1lhHA+M0rcvTSLFabl2vHfUIldjBJnPs1ghXBeMEp8uzAPrIpNwFxi0d6ljCC2
        iECixOnd+8CKmAW6mCUmP54C5HBwcArYSWx+KQNSIywQInFmy2E2EJtFQEWiZc4EZhCbV8BS
        4viG82wQtqDEyZlPWEBsZgFtiWULXzNDXKQg8fPpMlaIXWES+ycfYYWoEZc4+rOHGWSvhMAb
        Donrzx4xQjS4SCz8uQHqHWGJV8e3sEPYUhIv+9ug7HyJaR+b2SDsCom2jxuYIGx7iQNX5rCA
        3M8soCmxfpc+RFhWYuqpdUwQe/kken8/gSrnldgxD8ZWlVi/fBPUCdIS+67vZZzAqDQLyWuz
        kLw2C8kLsxC2LWBkWcUomVpQnJueWmxaYJiXWg6P8eT83E2M4CSu5bmD8e6DD3qHGJk4GA8x
        SnAwK4nwitRkJgvxpiRWVqUW5ccXleakFh9iNAWG90RmKdHkfGAeySuJNzSxNDAxMzMzsTQ2
        M1QS5108QytZSCA9sSQ1OzW1ILUIpo+Jg1OqgcnEf9O+jDguprlKWldKKi0OSt1Yu0A9Wjyk
        Ja5jxV529nfNTTU596acupuU9bJC/6pstJGxYv9ev/UNYm2n5ZYn112/bHCxOmEz906m/09r
        DgSbePiHSP06ndmp/jv6RcqkTzsXvXPJef/ucerS/AvWnny5fBde6/mHbb1UsmV2at4C3wz9
        4OVxbJNN2oVuXv0+O7HwbPzR6oeCyu837jtsxOtg/muh0Sa/VZ8LcmV/zXWLEfxtsf7IDK7C
        8xOeij/YqZRae/LjORVVy4TMTZ76nmv6jq9KNrfmueXouvKTe2XfQZf+iqCLD26mfe0UvDqN
        W+nepv8eLdqXNl+oecLg9qvmqumm42/e7JNqvqjEUpyRaKjFXFScCACD7FG2awQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsWy7bCSvK77q8xkg0kLFSwezNvGZnHl4iEm
        i0Obt7JbTH34hM1i/pFzrBZ9Lx4yW+x9DRT7dqWDyeLyrjlsFjPO72OyWLT1C7tF565+VotZ
        F3awWvzfs4Pd4vCbdlaLDd/XMjoIeGz43MTmsXPWXXaPTas62TzuXNvD5rHv7TI2j74tqxg9
        1m+5yuLxeZNcAEcUl01Kak5mWWqRvl0CV8bvzqmMBbvcKlY+38LawPjWtIuRk0NCwETi2vHf
        jF2MXBxCAjsYJRYvfskMkZCWmN6/hw3CFpZY+e85O0TRM0aJQwd2MoEk2ATMJRbtXQrUzcEh
        IpAo8eypOUgNs8AMZonVHXugpp5hkpgx9zgzSBGngJ3E5pcyIL3CAkESS6ZMZQGxWQRUJFrm
        TABbzCtgKXF8w3k2CFtQ4uTMJ2A1zALaEr0PWxlh7GULX0MdqiDx8+kyVhBbRCBMYv/kI6wQ
        NeISR3/2ME9gFJ6FZNQsJKNmIRk1C0nLAkaWVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5
        uZsYwXGspbWDcc+qD3qHGJk4GA8xSnAwK4nwitRkJgvxpiRWVqUW5ccXleakFh9ilOZgURLn
        vdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXAlMQ9r7EhymLR47cLBD8UO5Vae3HmyF9QjY0TUFU5
        fOZ+4tp/lcn5G2dtz1rw/2did45GnKKV4aElPqJtXEzMN39HcYo67w5ecm+FW5elhnPX4p7c
        pCrnVN/pcpLzH1q67Hx10ubZFUfhU84m4tZMrQkX4+TPbAzWPqVoufWCZCqjPV/Oy1/zLuuc
        qdi3Z63A2k6m803fTj7tKfxktEFZ9eAa7lsqkX2TUy94PeKc1JJVcaRkw8kjdtFWxp7LmMTv
        9ynmXD2wSX/VaddLLyuXFV5+UGTHn3dS+dsM7aKlZdH9HNu/dwVoHln8NKq3/VlqZb/XdI9N
        d05wny6deuDMIRH5p2oqNv1TX2vmi79UYinOSDTUYi4qTgQAzW3/6FIDAAA=
X-CMS-MailID: 20221108053359epcas5p2f95f5a32b2193759f39dbb51759850e6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221014104901epcas5p1a61ea81c3b1640bd8a064633c0b1e40d
References: <20221014102151.108539-1-p.rajanbabu@samsung.com>
        <CGME20221014104901epcas5p1a61ea81c3b1640bd8a064633c0b1e40d@epcas5p1.samsung.com>
        <20221014102151.108539-4-p.rajanbabu@samsung.com>
        <20221014151325.GA1940481-robh@kernel.org>
        <04b901d8e529$573b17e0$05b147a0$@samsung.com>
        <253fc459-c3dc-7710-6f34-0466d5301482@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=5D
> Sent: 22 October 2022 10:19 PM
> To: Padmanabhan Rajanbabu <p.rajanbabu=40samsung.com>; 'Rob Herring'
> <robh=40kernel.org>
> Cc: lgirdwood=40gmail.com; broonie=40kernel.org;
> krzysztof.kozlowski+dt=40linaro.org; s.nawrocki=40samsung.com;
> perex=40perex.cz; tiwai=40suse.com; pankaj.dubey=40samsung.com;
> alim.akhtar=40samsung.com; rcsekar=40samsung.com;
> aswani.reddy=40samsung.com; alsa-devel=40alsa-project.org;
> devicetree=40vger.kernel.org; linux-kernel=40vger.kernel.org; linux-samsu=
ng-
> soc=40vger.kernel.org
> Subject: Re: =5BPATCH 3/6=5D dt-bindings: sound: Add sound card bindings =
for
> Tesla FSD
>=20
> On 21/10/2022 04:44, Padmanabhan Rajanbabu wrote:
> >> On Fri, Oct 14, 2022 at 03:51:48PM +0530, Padmanabhan Rajanbabu wrote:
> >>> Add dt-binding reference document to configure the DAI link for
> >>> Tesla FSD sound card driver.
> >>
> >> The simple-card or graph-card bindings don't work for you?
> > Thank you for reviewing the patch.
> >
> > The actual reason for having a custom sound card driver lies in the
> > fact that the Samsung i2s cpu dai requires configuration of some
> > Samsung specific properties like rfs, bfs, codec clock direction and
> > root clock source. We do not have flexibility of configuring the same
> > in simple card driver (sound/soc/generic/simple-card.c) or audio graph
> > card driver (sound/soc/generic/audio-graph-card.c). The binding has
> > been added to support the custom sound card driver.
> >
> > I understand from your query that the newly added card has device tree
> > nodes and properties which are used in simple card as well, but having
> > a different or new prefixes. I believe to address that, we can
> > restructure the string names to generic ones.
>=20
> You must use generic, existing properties where applicable.

Okay

>=20
> > But I would like to understand, to reuse the simple card or audio
> > graph card bindings, can we add secondary compatible strings in the
> > simple card dt-binding for the custom sound card to probe ?
>=20
> If you see other vendor compatibles there, then yes... But there aren't a=
ny,
> right?

Yes you are right, we don't see other vendor compatibles. But, am I allowed
to add such secondary compatibles so that we can extend the simple card
and its utilities to a large extent?

If no, then I believe we will need a separate binding to extend the generic
properties.
>=20
> >>
> >>>
> >>> Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu=40samsung.com>
> >>> ---
> >>>  .../bindings/sound/tesla,fsd-card.yaml        =7C 158 ++++++++++++++=
++++
> >>>  1 file changed, 158 insertions(+)
> >>>  create mode 100644
> >>> Documentation/devicetree/bindings/sound/tesla,fsd-card.yaml
> >>>
> >>> diff --git
> >>> a/Documentation/devicetree/bindings/sound/tesla,fsd-card.yaml
> >>> b/Documentation/devicetree/bindings/sound/tesla,fsd-card.yaml
> >>> new file mode 100644
> >>> index 000000000000..4bd590f4ee27
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/sound/tesla,fsd-card.yaml
> >>> =40=40 -0,0 +1,158 =40=40
> >>> +=23 SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) =23
> >>> +Copyright
> >>> +2022 Samsung Electronics Co. Ltd.
> >>> +%YAML 1.2
> >>> +---
> >>> +=24id:
> >>> +https://protect2.fireeye.com/v1/url?k=3D4ae54403-157e7d1c-4ae4cf4c-
> >> 000b
> >>> +abdfecba-9eb398ea304f8ae8&q=3D1&e=3D4935bed0-ce62-47dd-8faf-
> >> 4750b01e22d3&
> >>>
> >>
> +u=3Dhttp%3A%2F%2Fdevicetree.org%2Fschemas%2Fsound%2Ftesla%2Cfsd-
> >> card.ya
> >>> +ml%23
> >>> +=24schema:
> >>> +https://protect2.fireeye.com/v1/url?k=3D8c72226e-d3e91b71-8c73a921-
> >> 000b
> >>> +abdfecba-3ce999f6c052255b&q=3D1&e=3D4935bed0-ce62-47dd-8faf-
> >> 4750b01e22d3&
> >>> +u=3Dhttp%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
> >>> +
> >>> +title: Tesla FSD ASoC sound card driver
> >>> +
> >>> +maintainers:
> >>> +  - Padmanabhan Rajanbabu <p.rajanbabu=40samsung.com>
> >>> +
> >>> +description: =7C
> >>> +  This binding describes the node properties and essential DT
> >>> +entries of FSD
> >>> +  SoC sound card node
> >>> +
> >>> +select: false
> >>
> >> Never apply this schema. Why?
> > Sorry about it, let me change the select property to true in the next
> > patchset
>=20
> No, just drop it. Look at other bindings or at example-schema
>=20
> >>
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    enum:
> >>> +      - tesla,fsd-sndcard
> >>> +
> >>> +  model:
> >>> +    description: Describes the Name of the sound card
> >>> +    =24ref: /schemas/types.yaml=23/definitions/string
> >>> +
> >>> +  widgets:
> >>> +    description: A list of DAPM widgets in the sound card. Each
> >>> + entry
> > is a pair
> >>> +      of strings, the first being the widget name and the second
> >>> + being
> > the
> >>> +      widget alias
> >>> +    =24ref: /schemas/types.yaml=23/definitions/string-array
> >>> +
> >>> +  audio-routing:
> >>> +    description: A list of the connections between audio components.
> > Each entry
> >>> +      is a pair of strings, the first being the connection's sink,
> >>> + the
> > second
> >>> +      being the connection's source
> >>> +    =24ref: /schemas/types.yaml=23/definitions/string-array
> >>> +
> >>> +  dai-tdm-slot-num:
> >>> +    description: Enables TDM mode and specifies the number of TDM
> >>> + slots
> > to be
> >>> +      enabled
> >>> +    =24ref: /schemas/types.yaml=23/definitions/uint32
> >>> +    enum: =5B0, 1, 2, 3, 4, 5, 6, 7, 8=5D
> >>
> >> maximum: 8
> > Okay
> >>
> >>> +    default: 2
> >>> +
> >>> +  dai-tdm-slot-width:
> >>> +    description: Specifies the slot width of each TDm slot enabled
> >>> +    =24ref: /schemas/types.yaml=23/definitions/uint32
> >>> +    enum: =5B8, 16, 24=5D
> >>> +    default: 16
> >>
> >> All the above have types defined. You should not be redefining the typ=
es.
> > Okay
> >>
> >>> +
> >>> +  dai-link:
> >>> +    description: Holds the DAI link data between CPU, Codec and
> > Platform
> >>> +    type: object
> >>
> >>        additionalProperties: false
> > okay
> >>
> >>> +    properties:
> >>> +      link-name:
> >>> +        description: Specifies the name of the DAI link
> >>> +        =24ref: /schemas/types.yaml=23/definitions/string
> >>> +
> >>> +      dai-format:
> >>> +        description: Specifies the serial data format of CPU DAI
> >>> +        =24ref: /schemas/types.yaml=23/definitions/string
> >>> +
> >>> +      tesla,bitclock-master:
> >>> +        description: Specifies the phandle of bitclock master DAI
> >>> +        =24ref: /schemas/types.yaml=23/definitions/phandle
> >>> +
> >>> +      tesla,frame-master:
> >>> +        description: Specifies the phandle of frameclock master DAI
> >>> +        =24ref: /schemas/types.yaml=23/definitions/phandle
> >>
> >> These are common properties. Drop 'tesla'.
> > Okay
> >>
> >>> +
> >>> +      cpu:
> >>> +        description: Holds the CPU DAI node and instance
> >>> +        type: object
> >>
> >>            additionalProperties: false
> > Okay
> >>
> >>> +        properties:
> >>> +          sound-dai:
> >>> +            description: Specifies the phandle of CPU DAI node
> >>> +            =24ref: /schemas/types.yaml=23/definitions/phandle-array
> >>> +
> >>> +        required:
> >>> +          - sound-dai
> >>> +
> >>> +      codec:
> >>> +        description: Holds the Codec DAI node and instance
> >>> +        type: object
> >>
> >>            additionalProperties: false
> > Okay
> >>
> >>> +        properties:
> >>> +          sound-dai:
> >>> +            description: Specifies the phandle of Codec DAI node
> >>> +            =24ref: /schemas/types.yaml=23/definitions/phandle-array
> >>
> >> Already has a type. Need to define how many entries (maxItems: 1 ?).
> > Okay. I'll update in the upcoming patch set
> >>
> >>> +
> >>> +        required:
> >>> +          - sound-dai
> >>> +
> >>> +    required:
> >>> +      - link-name
> >>> +      - dai-format
> >>> +      - tesla,bitclock-master
> >>> +      - tesla,frame-master
> >>> +      - cpu
> >>> +
> >>> +dependencies:
> >>> +  dai-tdm-slot-width: =5B 'dai-tdm-slot-num' =5D
> >>
> >> This should be captured with tdm-slot.txt converted to schema.
> > Okay
> >>
> >>> +
> >>> +required:
> >>> +  - compatible
> >>> +  - model
> >>> +  - dai-link
> >>> +
> >>> +additionalProperties: false
> >>> +
> >>> +examples:
> >>> +  - =7C
> >>> +    sound =7B
> >>> +        compatible =3D =22tesla,fsd-sndcard=22;
> >>> +        status =3D =22disabled=22;
> >>
> >> Why have a disabled example? Other than your example won't pass your
> >> schema.
> > Thanks for noticing, I'll double check and change the example keeping
> > the status as enabled
>=20
> No, just drop. Start with example-schema instead.
>=20
> Best regards,
> Krzysztof


