Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A989E63CCFA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 02:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbiK3Bmc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 29 Nov 2022 20:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiK3Bma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 20:42:30 -0500
Received: from mo-csw.securemx.jp (mo-csw1515.securemx.jp [210.130.202.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD40F4A066;
        Tue, 29 Nov 2022 17:42:27 -0800 (PST)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 2AU1fUPp028204; Wed, 30 Nov 2022 10:41:30 +0900
X-Iguazu-Qid: 34trkiKD1zOnSZEeWa
X-Iguazu-QSIG: v=2; s=0; t=1669772490; q=34trkiKD1zOnSZEeWa; m=s/u0X6TnRBzMpT2vpAQdpQIuJYLPwRvZe7hT/V42Vas=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1511) id 2AU1fQZR003595
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 30 Nov 2022 10:41:27 +0900
X-SA-MID: 50511993
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LD1GiKb5nYw5isDORHnrvQxhSnWZZNbBMQVp9B8PF98u+8UDJ0qdXwhYmFq9/BCB4Nd5UCNXMvXgkGdhiYkuPbOJewGp9mHk9ROrzHii54z3eQodR5x1+alW8VDQDYCOzsyHh+1UlL3UJjvrjkjR9c4QqUD4rxyrKbfNiPSjjM7qIgVKo2Da+N4EZnmkmra99U87hbnpOfTWegsPT5owc7sicNrZ7/cnGsOCwaBiZlUlJ56+4DBzC4nQvEauWp/72lVvhgeLEFRDgwPo+kiUDpQ5Gjtm3B4p263vr25kSap0WxNDNAyyOu7LoDcg7++jw5pMIMmYV+pu/LvtRgxPng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRM4xJ5YcjcHm+Uu7zQxdM0ZA7MNeB/oAvll5ibYybQ=;
 b=komBBt2LCA+j7hXaNlYU6NlPFc80dreZLqF10p4ayJEy5WgJi9pqeYs3a+6iGUPG24q/P/B2aLJKBu6R5J5wtKtz2Z4zqrxbYPuAT22d062OAzWfH+reVXBVMUKfvWwwGKKiG17LOf6fI42iri2O7+yNHCW7Tjd+4bV99u7hU/JeDPVzxVxub4ImeMvqJzdDcy536T+sG8QIhFvNRfVG+m3JSKknB/fJkKb+02Cacdgu5p5oGrHZqUhoXaiMU/C9iw6/mSCYp4S0S5iR9fRqm6iS8Xf2bOQ9qih96CxtqLUN34tfE+772H4DhTIV+6/49fzjmhlKIKXxW18F6rS+/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <yuji2.ishikawa@toshiba.co.jp>
To:     <robh@kernel.org>
CC:     <hverkuil@xs4all.nl>, <laurent.pinchart@ideasonboard.com>,
        <mchehab@kernel.org>, <nobuhiro1.iwamatsu@toshiba.co.jp>,
        <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: RE: [PATCH v3 1/4] dt-bindings: media: platform: visconti: Add
 Toshiba Visconti Video Input Interface bindings
Thread-Topic: [PATCH v3 1/4] dt-bindings: media: platform: visconti: Add
 Toshiba Visconti Video Input Interface bindings
Thread-Index: AQHYrL0T1ap+U+r1qk+2w9IindSRaK2oRN8AgK8NMWA=
Date:   Wed, 30 Nov 2022 01:36:18 +0000
X-TSB-HOP2: ON
Message-ID: <TYAPR01MB6201D43FD70094EC613CAF3092159@TYAPR01MB6201.jpnprd01.prod.outlook.com>
References: <20220810132822.32534-1-yuji2.ishikawa@toshiba.co.jp>
 <20220810132822.32534-2-yuji2.ishikawa@toshiba.co.jp>
 <20220810153802.GA585-robh@kernel.org>
In-Reply-To: <20220810153802.GA585-robh@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6201:EE_|OSZPR01MB9360:EE_
x-ms-office365-filtering-correlation-id: 0aa5eef8-a4ac-4ea3-2609-08dad2734733
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kpnA8Yz3jntgwvfc8W2vOke4gLdrrFdWLnzeMmP5lcuM+a1v7PN0cfCFAnephgab/m5ckq27a+YNeYl3Sls1WjUvlgSPlYtDebDOeSWjmorKTtsOsxsR/g9uzplfOP9/uPbsZf9NE057NvcvmT4PWZRQXReOqAgoW0fMc6yut8xz6H10muF81qHFYkQbmULvOaKlzP8hfQUoU/7AZhArIJ9HaukbEVMVpK3ZdwSIlCQp9anJRH+7KQrNZ7RG4L28warUs53ZZ/a3a5h/r9JAjA9L+pRNdlrKpW46z88xckQs66Q+JAhIJRlyGQCtudK133FImsqp9O91fHGDRM6k0ND/Z23jecAud1diDSgfrrk9cMcgm5v4Eb3HZLP/Rn57FFBU0xvFAqRwOgrrfomp1oKfJ7ZVZvAAiC4sn3r94c13gSJk+fMjD+e76X5c7I2HwFl244VKMmETkcdpSOv6Dtue0SsodY7t0kKma+ix+3UrEX7Ne1yyxh9wbkgfllJeEgrKj1jOxzCVTUHgYGb0RD/7KVSnKxSFwtvvvNY43Kwy8RiQQwomUV3/OCpjhj3Gh2WlGHDdq5GHDNm77AdRzYuyk5d4B1XMXxi4lFVQEUwu6sTo5+28PNAAshNGiPLPptgO3xVQ7EuaS2djGaGQPVoeps+anRXqMjWuXfegLxDHMRA1lbUp7TzouCU8hWcnVs6ujDvzJhLBcAXU0606p9BkyqVVNiBnYI4bfsjTyxs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6201.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199015)(2906002)(6506007)(41300700001)(4326008)(66476007)(6916009)(66556008)(54906003)(8676002)(186003)(64756008)(316002)(52536014)(8936002)(76116006)(71200400001)(5660300002)(33656002)(86362001)(26005)(478600001)(966005)(66446008)(7696005)(66946007)(53546011)(9686003)(122000001)(38070700005)(38100700002)(83380400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?TmhpNFM5N0tHdGlBUUpYWlY5SDhOcXAzWkpoUWIxWXZwV0J3L0VWNk5C?=
 =?iso-2022-jp?B?MEJvc2JkaFlYOGZsVnVMUjl4TTFkOWdDQVBROWRJVXVkTEJkNUR6aEJN?=
 =?iso-2022-jp?B?RUEzWWhLcWpWOWZBVkRpdzFUSWU5bklsYktDeUpqK3NUeWN0YTN0aGt4?=
 =?iso-2022-jp?B?cWFqVWRtOU4wd2MwSnhIME9EQkdiMkNXVGl1dm5RTXZGTjZxWCtNSHFC?=
 =?iso-2022-jp?B?Z3c2dVJIdjBiSDdITG15R05iVSsvUC94REZGWVZQTU1VcWx4NUp5RVBQ?=
 =?iso-2022-jp?B?N1lwRThQUFV2MDBwTGNTbXo1bkhjazYyclNBOFdsN3Zsc2xGYlRGWldP?=
 =?iso-2022-jp?B?TTV6dEM0UzM0eEQvY3lwWlNhUkp4c3ZtR3BoNDd1clNnU05TNnR4WFlQ?=
 =?iso-2022-jp?B?SUhSTVFyVENNbmQza1pqQVJXbmo3akltZG1BWkRRV2RabjZJcU9pQ2M2?=
 =?iso-2022-jp?B?V2twWWtUUmZhbFJqNG4vcEY1T3BiVk9mb3VmRSs0UWwrTjRScmM0NUZF?=
 =?iso-2022-jp?B?dlhCZ2pXS3JCMm9zcnZ6RytrRWJjOTcxcFRJUGQvak9KdTFicjFSK3lY?=
 =?iso-2022-jp?B?Vmw1OWdEdzB0WStvNDMzWSt5K2FWZGpqazcyRnliTjhvOXk2NFpTTW43?=
 =?iso-2022-jp?B?WUI0em5IVTFHaDB2WGpESkk2NEVVd01jRjhZaUZ0T1Bjdm1aVmM0R1Jj?=
 =?iso-2022-jp?B?cGEvcExkUk05RkxGdUVYYWhoa0NtTXIvUE1Dd0xHeFpBajcxT0EvVDJT?=
 =?iso-2022-jp?B?K2s2WFI2cnRRcGlOMDlyaVhPeGNsSmkwVkhRK1ZyUDNaL3NtUUpUQitQ?=
 =?iso-2022-jp?B?em53cHEzRXlqYURVdGpxSTVPZDZpdklucXBGNEx5aWpkS3dqWEZqdjls?=
 =?iso-2022-jp?B?YmtOZDVVS2VDN2M4S29oeXlCTTErNGZISGRsZ2d0UUc3bG9NK2liS05r?=
 =?iso-2022-jp?B?ay9yeExtZFVBcUF3dzlRL3hYU0tsdDgwNStBYlN6djdkbTIvQ2xsc0Rh?=
 =?iso-2022-jp?B?TlRzTzZuWFlGSnNEZGNBbWdXYitwYVZOVjQwUTE1b0s3ZDV0Qkp5L3hi?=
 =?iso-2022-jp?B?SVV4S1IwbUpUUU5Cc2dOd3l5U2dkNEpwVmUxRU9iZnQ0RWRzMmFHdUFy?=
 =?iso-2022-jp?B?cDFlZmhoL3FwdFU4TFpScGs2L3ZlN1dsT0RPWWRHbks5b2kvUUdPNGRs?=
 =?iso-2022-jp?B?ZC82eUw1a0hncGt3S0prMklNa2dZZHc5TERjNlZLUUZwSjQrMWNkR3ZJ?=
 =?iso-2022-jp?B?YkFUZ2hGQ1MwZWtSTVNCNStWSUNtZWVjeHNtaG1PQXZsMFhxS3RnU1p2?=
 =?iso-2022-jp?B?OWNYbkFyWWJvZzdhZUlzZ0VkSkFVUDdjalNRWHg0WWZtVVBWYlM1ZGI1?=
 =?iso-2022-jp?B?T25pcFdhNTJjTE1rT3hnUVdBZm9IUUVhS0taZEFXYnBLWkhnRTNneTZZ?=
 =?iso-2022-jp?B?U05qM0FUcUh4dUpjMVhwa1lLUFB5bTY5OVA4V1d3a2hlay9pMmFSSWNp?=
 =?iso-2022-jp?B?VkNtNDZ6NWlmeVhxOHpnSjhueWF0UUVaS3I5aEVNeFdpbUlPWmFVT3ZW?=
 =?iso-2022-jp?B?aGpucU4yd3dHa1NBK3ZtVE5pWXh0bHloUndRVVQ0T0FRTDFCZkJyL21M?=
 =?iso-2022-jp?B?OXBLaHFzc0dyZHRoKzErSTZJWU00bTFKUnlTVUNUMUZvbXQ0eVlxQlJ5?=
 =?iso-2022-jp?B?dXROMEpabjg1MU5yTEY1aWJGQ0NxMTkwVDVaNWdScXpkdmIxUFg5S3E4?=
 =?iso-2022-jp?B?OEFxdGJzaCtOcnVsQzFjT3pITUVyWTMwMHJaSjFEbmx0RVBBT0dYM3Np?=
 =?iso-2022-jp?B?bnhBbFVjSlBpVnFrckpHbTY2OFRFc1U0UEFOQS90cm04V1kzMUtHNjdk?=
 =?iso-2022-jp?B?eUhhZ2tyQ1FSektiSFlESS9wU1ZPbHJTYThwZkVPQTZMZjd0eWwvb0FG?=
 =?iso-2022-jp?B?cDZHdEVYb0tNcWtNVjFhOVM4U2tJNUU0NlkxeHVOYVdPblhyWnRRRFhW?=
 =?iso-2022-jp?B?NEp6cW5BbDBKYldJUTBGWmRZSTFUaHlJSDRrL1hham9qMmFNNmp2R0Ru?=
 =?iso-2022-jp?B?cWpBd3p4Q3BRYkdvVEpHcDVmZ1dNNUkxeWZSQkZ4WEVWd0FrZStJQW4y?=
 =?iso-2022-jp?B?Zkxtd09LQmtYNjZvVHlLdDN4ZGpLeUVXQ1NrdDJ4cW4ycWptT0FsN0Nv?=
 =?iso-2022-jp?B?Zjd3NWdLVW95a3hqSDQ4VnpwKzJyU0NnRWNyUWJtRnR0VTNzOXNMOEFl?=
 =?iso-2022-jp?B?ZFpkdTRsUzNWSmNMaDQvSUg3bzZ1RGtDTUc3RGlBRlJqbXlPdU9qU1pS?=
 =?iso-2022-jp?B?QVN4dFVqdzJNSDRvbnBMYXMyQWdxcCs2Z0E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6201.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa5eef8-a4ac-4ea3-2609-08dad2734733
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2022 01:36:18.3640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nmJbLzRxlkkFPhLnbkmSV5vs6eHSxe4OB2onONM332J9UOVSfb0iNomitg5PdXdbqWFigZjYBo9GyKG+GGIcH1gOWnH9+VyVxt19F/YkOuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9360
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

Thank you for your comments and sorry for this too late reply.

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Thursday, August 11, 2022 12:38 AM
> To: ishikawa yuji(石川 悠司 ○ＲＤＣ□ＡＩＴＣ○ＥＡ開)
> <yuji2.ishikawa@toshiba.co.jp>
> Cc: Hans Verkuil <hverkuil@xs4all.nl>; Laurent Pinchart
> <laurent.pinchart@ideasonboard.com>; Mauro Carvalho Chehab
> <mchehab@kernel.org>; iwamatsu nobuhiro(岩松 信洋 □ＳＷＣ◯ＡＣＴ)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; linux-media@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org
> Subject: Re: [PATCH v3 1/4] dt-bindings: media: platform: visconti: Add Toshiba
> Visconti Video Input Interface bindings
> 
> On Wed, Aug 10, 2022 at 10:28:19PM +0900, Yuji Ishikawa wrote:
> > Adds the Device Tree binding documentation that allows to describe the
> > Video Input Interface found in Toshiba Visconti SoCs.
> >
> > Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
> > Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > ---
> > Chengelog v2:
> > - no change
> >
> > Changelog v3:
> > - no change
> > ---
> >  .../bindings/media/toshiba,visconti-viif.yaml | 103
> > ++++++++++++++++++
> >  1 file changed, 103 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
> > b/Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
> > new file mode 100644
> > index 000000000..848ea5019
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/toshiba,visconti-viif.ya
> > +++ ml
> > @@ -0,0 +1,103 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/toshiba,visconti-viif.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Toshiba Visconti5 SoC Video Input Interface Device Tree
> > +Bindings
> > +
> > +maintainers:
> > +  - Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > +
> > +description: |
> 
> Don't need '|' if no formatting.

I'll remove '|'.

> > +  Toshiba Visconti5 SoC Video Input Interface (VIIF) receives MIPI
> > + CSI2 video stream,  processes the stream with embedded image signal
> processor (L1ISP, L2ISP), then stores pictures to main memory.
> 
> Wrap lines at 80 char.

I'll update the description.

> > +
> > +properties:
> > +  compatible:
> > +    const: toshiba,visconti-viif
> > +
> > +  reg:
> > +    items:
> > +      - description: registers for capture control
> > +      - description: registers for CSI2 receiver control
> > +
> > +  interrupts:
> > +    items:
> > +      - description: Sync Interrupt
> > +      - description: Status (Error) Interrupt
> > +      - description: CSI2 Receiver Interrupt
> > +      - description: L1ISP Interrupt
> > +
> > +  index:
> > +    enum: [0, 1]
> 
> No, we don't do indices in DT. Why do you need this?

The property 'index' can have value <0> or <1>. 
A node with 'index=<0>' corresponds to 0'th VIIF HW instance (VIIF0).
Also, there's 1'st VIIF HW instance (VIIF1) with a bit different operation-mode set.

Sorry for asking question for a comment months ago.
Let me clarify:
* The problem is NOT defining style of 'index' with enum
* The problem is NOT that 'index' is reserved keyword
* The problem is having additional sequential ID for a node, 
  while 'reg' (usually, the base address of registers) can identify instance.
  Therefore, 'index' should be removed, 
  and vendor-specific property can be used to declare each feature only on VIIF1.

Is this correct understanding or am I still missing the point?

> > +
> > +  port:
> > +    $ref: /schemas/graph.yaml#/$defs/port-base
> > +    unevaluatedProperties: false
> > +    description: Input port node, single endpoint describing the CSI-2
> transmitter.
> > +
> > +    properties:
> > +      endpoint:
> > +        $ref: video-interfaces.yaml#
> > +        unevaluatedProperties: false
> > +
> > +        properties:
> > +          data-lanes:
> > +            description: VIIF supports 2 or 4 data lines
> > +            items:
> > +              minItems: 1
> > +              maxItems: 4
> > +              items:
> > +                - const: 1
> > +                - const: 2
> > +                - const: 3
> > +                - const: 4
> 
> blank line

I'll fix this

> 
> > +          clock-lanes:
> > +            description: VIIF supports 1 clock line
> > +            const: 0
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - port
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    soc {
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +
> > +        viif0: viif@1c000000 {
> 
> Drop unused labels.

I'll fix this.

> 
> > +            compatible = "toshiba,visconti-viif";
> > +            reg = <0 0x1c000000 0 0x6000>,
> > +                  <0 0x1c008000 0 0x400>;
> > +            interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
> > +            index = <0>;
> > +            status = "disabled";
> 
> Why is your example disabled? Don't put 'status' in examples.

I'll remove 'status'.

> 
> > +
> > +            port {
> > +                #address-cells = <1>;
> > +                #size-cells = <0>;
> > +
> > +                csi_in0: endpoint {
> > +                    remote-endpoint = <&imx219_out0>;
> > +                    bus-type = <4>;
> > +                    data-lanes = <1 2>;
> > +                    clock-lanes = <0>;
> > +                    clock-noncontinuous;
> > +                    link-frequencies = /bits/ 64 <456000000>;
> > +                };
> > +            };
> > +        };
> > +    };
> > +
> > --
> > 2.17.1
> >
> >
> >

Regards,
Yuji Ishikawa

