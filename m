Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4007030D6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241891AbjEOPB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241547AbjEOPBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:01:18 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2079.outbound.protection.outlook.com [40.107.7.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BD81BCC;
        Mon, 15 May 2023 08:01:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHsksdh1Vz3YErMQtePMysAzxtupXaz4hYvFysG8Jt+3rcLvJz8oWb/FXdr3ab7GQiYk71heKq8oDXRwdq9dtXQ77m24fx0AG9u4jhdUmyxA984ZN3+2j0r8+YFiEkV6eIc4eQ15EhihOF7/54lmqiDNRNJv+TeMfWiZ6V7fQ39mzbEd7i8asKlWGQS2cSHpJK7RINXN/Q3ewyj7pOJpKMFhw+ilYNGBo9gufv6eEbp8bAAIW8gKlwppNVyrQ04G38Tbhmvr44mo1Q7++OYAX0hU9K/cZgSOC7bY3xD/fi3IV87VE5HCwwkQGEDSYWlgemSgCC4pyN6T15vAlqoOqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2B0A3FeBz4LnUbKf47NFwdHTKByHJWHe0IhxqVwHrU=;
 b=jU111r77Re6RyfjO8Ix27udKeoLfVMWrbpz8nlil3emCDTJtCY0kOBip0QAnyaQG6LDZ2FBwuPvo/D9c/nplRcQX5KNsDxfXDy5tWZw9KLN9YTKVephp0pggXcKK7+3HYeoKxfgojdZhr1UKET61vt16viABsAHi3YYLlKk0RrVslr4/qPW0Iu9jPJczAnatcErjpe7aiVucLEygXM4JMaOTMhCC52CeV4UCXImnNTWY9frDDc/U52ohMl83ngFYD9v+opV1wUZ0EuAQvN0121MX388bdix4kWhKHI3rqOH0yV9oTJQpZhZfbLVSc/Im/jBPNSa3CzJpScoTuS2EIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2B0A3FeBz4LnUbKf47NFwdHTKByHJWHe0IhxqVwHrU=;
 b=RyMfQNSDMCK1NjeKvNRobK49+v6U3eJNIGHqHtoTk+JOfolb3uhL2inUr4mrbYmy8R3LhtCk1cyI84rut87NkLeSnEP4scBTtRa5UbryUUBpi95SA4FGGCe1wety/EQv0rQdykZWA1eHzQjOy/Mxk1fl4tJivjXh7NiMHDUJn2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by VI1PR08MB9982.eurprd08.prod.outlook.com (2603:10a6:800:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Mon, 15 May
 2023 15:01:06 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 15:01:06 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Mon, 15 May 2023 17:00:59 +0200
Subject: [PATCH v2 2/4] dt-bindings: touchscreen: add virtual-touchscreen
 and virtual-buttons properties
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230510-feature-ts_virtobj_patch-v2-2-f68a6bfe7a0f@wolfvision.net>
References: <20230510-feature-ts_virtobj_patch-v2-0-f68a6bfe7a0f@wolfvision.net>
In-Reply-To: <20230510-feature-ts_virtobj_patch-v2-0-f68a6bfe7a0f@wolfvision.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684162864; l=8153;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=QxvMvto/x5XLmhjZ2TbUw5YHv6JL/NthIoSVo7Q2ReE=;
 b=y49lBfaZ0RNiO3hEYbRqMdT/J6FZz6aI+3xGFEZoSWJ1R7FPwrJWo2Xq63GBau7SOzfE2F4LP
 epBbe7xJKeeDYXAI/lh8sIgrF26MzsRXzjyhxWkjyUdKEtGUD+yh7CI
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1P195CA0039.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::28) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|VI1PR08MB9982:EE_
X-MS-Office365-Filtering-Correlation-Id: a20afc66-8c3d-4cf2-bb1a-08db55553535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ajtihGuFBVyNRqfgWLWpboXVvMvryXFKtWodulG6CoTyb01GSUWUdahbG71c+PebSC0KibV//jCStGf33RA0S30Ij3K9+O/+2cr+IjsXFZTF9MNMuRkV9fTl/REfuODhm640tNKEeTEmNFohcO5OEyMa1wviwUPTNtR1uEqB0Nd5YzNlJ8cNdnxqNit/7hh1wsCKBtw9sDk8oLeRC4FpbkythJc+6fQgSj7GXprnXYzZL0njhuXU1SDNLQAK54qvISrDi7WIo5i0o6Jg37OdSO/wFjRLbTqChqHTDJoBk9eojRIND7Rjl8ZAi7cJZHxSE8iWCR6EmpT10QAq/51bQwcmCSUZ480UeSJbeZsRie0MX0udQTx3bfHeCspDI4cTKMUaJFsFKmyu3NVva8BHuQYV57BtEELsAx7OtwL3lHFq3ueYg2KeNa1CbOMrky5NCxSAou/i+Tk1S8XyGud4aQSZh3bGY76SFPP1E0kVaco3kMJqGNtXipNpg2OukQQnz+kdbsDhIIaAkBbgXxKla9rvzFp5nb1rcbIy7l02/OuVKy1okWaunbTXyaTZk0irmcHaC7Ne55y34PvOtfMZiGRLXZv4/cSkwKuY6f93UB6XbkottvzV0xXsM7frL0CG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(366004)(39840400004)(451199021)(478600001)(2616005)(86362001)(6486002)(6512007)(6506007)(26005)(186003)(38100700002)(38350700002)(107886003)(36756003)(52116002)(6666004)(110136005)(2906002)(66946007)(66476007)(66556008)(5660300002)(316002)(6636002)(4326008)(44832011)(8676002)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmJOTFdpcWgrdm5mb1pQUDMwcStEL2ZhdHl4UTlTamE0YzEzVUJCQjFnNzB6?=
 =?utf-8?B?RmlObWc2QlRESU1rMk00dGJIak1GRkgvM0t4UkNHOTJlMURGQTljZEtIaUxy?=
 =?utf-8?B?dFVTSkNqdzdxV2tlVElxZ2dpRVFaTy9pWTJSQVpsMUdiU0pkcndoM1A2Mi9Z?=
 =?utf-8?B?aGUrVllTWDVPcDloVDVYSXVWZ2tKWGtRL3A3SUJoMkFrTklOeDhDVmFxR3ZM?=
 =?utf-8?B?cGNDNGNldzcyaWwrOFAwMVk5TlVadFVmTnZGNGcvN0RpMGNkNWhwbU9YU2N4?=
 =?utf-8?B?L3dlOHhBOHN4bDd2eUxYNmpta3NtY01nZWF3eEVyaXVJTWFxQW9xSGVmZE04?=
 =?utf-8?B?SlIwdWJ6VmxzRlNGTW41Nkh3Q1VuUDI0YlQ1TG90T1BYV01zZG9ySG02VHJK?=
 =?utf-8?B?U3laU2h5d1ZVR1FLNHV4QlNOZjBmZklEMG5iaXhHZ3c4Qkl4cndPZ2VqeHlC?=
 =?utf-8?B?ZGlmeXdBcDA5R3VmZTlMUmZTWWJjaVVlNFFneUFmOE4xR2FackdUT1YyZE1D?=
 =?utf-8?B?TVE4U1JrQ2lubWI2UHlYQ1JVeENvTldNOU1OZGNUUlhmTmlPWFNqMlkrUmxy?=
 =?utf-8?B?YlF4RDJiM1pNdUM2cThCR00vbFNPWVZzY1IrZFQ2UnAySlZNL2s5K21xQzdE?=
 =?utf-8?B?N3luZXY3Z2JGZnJOcjlVT3BVbkJmQWlkQ0lCdVEzMUVNYWxDQVIzbWY2V2Np?=
 =?utf-8?B?RGxqQXV6SHVzVUJZL0xZZzh6Z1JKWWdpaDhZTmVjd1dwc1JDd091d3JIbGZx?=
 =?utf-8?B?Wkg0WXJmNFIzTmlVcUlqdlZJZExGQXBuVUM2UXNQYlpVQ0JIL3JZVkVBNlRL?=
 =?utf-8?B?NjIvdXRCM29VTWN5dGFoRGJUL2FXckEvalE5eWZrRVZBZVltc0MrU1VFK3ln?=
 =?utf-8?B?VVp6aEgvcUlteG43TG5mYWo4Ry9kQ2puTlQ1TDdmTHNJb1pIOGNSdGphT2xP?=
 =?utf-8?B?NTkwd1hUV1pVRnBldVpBRG1aeHhieDFqQk5xYWlrVEVIcHNMQ3crVSt2bHZU?=
 =?utf-8?B?Q1J6ekcxOUw5ZmFlZ1VyNUZ1VlNjUUM2NEtFbFRUVEZ6cHN3eHRwWW5lUXdu?=
 =?utf-8?B?Y0lQKzlIcFAvYjdxSmdBdDhueHprMlhuS1RRcWRTNGEwMG1jeUlDRmtlaTVR?=
 =?utf-8?B?U1BOV0FEdDZ5VXlNRGJObDBLK1pCTThSQXQxM3BnWGliZk5KYXpZcFhXYlpl?=
 =?utf-8?B?S1lsRkFsbENCWHcrWWZmSGYzSzl5MkR1ZUZhTDJNRUVyeHlaQ2M2WUJIU21i?=
 =?utf-8?B?MHpjdGFUeTJ1d01IUUZUVVdNNlB5ZThEZ01UUTcrVWlpc25nc3FUbmpjeit2?=
 =?utf-8?B?S3RzcHFCakpCNXovSXUrMUdHWkV1V096YWJQNkt3TzFUV29JZm5yTTcxVVFt?=
 =?utf-8?B?ejNqUzUyUVpQV1d4TEdUV2JkRWt6SVRWeFI3UWlJZHNic0luOTVNOVBpVW1P?=
 =?utf-8?B?VjFnU3ZRTlBDeThnVS9xdjdPTU1pa1N2TEg1aGlyR3J2STNXY2Vtci9Qa2lX?=
 =?utf-8?B?RDh2QWtYNFF5alcrN0Npbm1tU0hDbm5FbGFleW9BbkxRd0pSMklLUnZkRjBD?=
 =?utf-8?B?ZE9RQ0pqUVhib2VyZE02RmNmOU5WSzd6MmlaeFFYZnIxNmlUd254Z0hlbWZj?=
 =?utf-8?B?OFIvVlhJRGJxaFNOTHBLZ1ZGUURJNlFiOHFYc0VsV0QwekhHUGtKOVJ1dHN0?=
 =?utf-8?B?c1NuMW15S0N6eXduem9uWHliaTFWUFdyMG5tT29XckNXcFpRcldkNXVGditw?=
 =?utf-8?B?S2VYWHlINEV5alF4NGhlTTl4WTI5d1RVYzVjVFhib0dmOG12c0J5QmVQM2xT?=
 =?utf-8?B?ZXdMc1Mvd3F1emlZeUhLVjZiTVdXWGlMc0xHUnQyODlrR0ZNSnBIZWNQVTEx?=
 =?utf-8?B?UVVpTlRnOVhDWlRSeENNdTU0L1p1SlozUCtncUdVb2RLb0hvT3IwK0FiRDB4?=
 =?utf-8?B?V3pLaUh1MWhnS01RT1NLenMxclJKTjFsY0E0Z2RCeDJHdnIvUG5SdUJRZFEz?=
 =?utf-8?B?b0N4OXUvQTI4a2NKVEdWcmlUNG95YVBqcmFFTUh4d2xNSTd1a3JBM2lOVG5S?=
 =?utf-8?B?WEd1WHVTUGYwd2xuR2pRZVRud251UkJHN2VidXBYenZSanhndXJkQXNNUUJq?=
 =?utf-8?B?a3FObXVpdlpYZml6KzFCVmxyV2JLNDRnY1RvY1huZFRlenVOUUVQYVZqL0gx?=
 =?utf-8?Q?/c35W+4JlDQl0cxFLmsbOE4=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a20afc66-8c3d-4cf2-bb1a-08db55553535
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 15:01:05.7545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmkv/yMPLENwtzlWylevIavpFw2o3aEBw7fYhm/lt3W7RUucjQ2KJFiiVX5AFDcX0Lm6YsHOPkO6+7Wvk4QzGql15UZ1COnjOyVm1tTbQxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB9982
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The virtual-touchscreen object defines an area within the touchscreen
where touch events are reported and their coordinates get converted to
the virtual origin. This object avoids getting events from areas that
are physically hidden by overlay frames.

For touchscreens where overlay buttons on the touchscreen surface are
provided, the virtual-buttons object contains a node for every button
and the key event that should be reported when pressed.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 .../bindings/input/touchscreen/touchscreen.yaml    | 139 +++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
index 895592da9626..866bfb45a8cf 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
@@ -80,6 +80,145 @@ properties:
   touchscreen-y-plate-ohms:
     description: Resistance of the Y-plate in Ohms
 
+  virtual-touchscreen:
+    description: Clipped touchscreen area
+
+      This object can be used to describe a frame that restricts the area
+      within touch events are reported, ignoring the events that occur outside
+      this area. This is of special interest if the touchscreen is shipped
+      with a physical overlay on top of it with a frame that hides some part
+      of the original touchscreen area.
+
+      The x-origin and y-origin properties of this object define the offset of
+      a new origin from where the touchscreen events are referenced.
+      This offset is applied to the events accordingly. The x-size and y-size
+      properties define the size of the virtual-touchscreen (effective area).
+
+      The following example shows the new touchscreen area and the new origin
+      (0',0') for the touch events generated by the device.
+
+                   Touchscreen (full area)
+         ┌────────────────────────────────────────┐
+         │    ┌───────────────────────────────┐   │
+         │    │                               │   │
+         │    ├ y-size                        │   │
+         │    │                               │   │
+         │    │      virtual-touchscreen      │   │
+         │    │                               │   │
+         │    │                               │   │
+         │    │            x-size             │   │
+         │   ┌└──────────────┴────────────────┘   │
+         │(0',0')                                 │
+        ┌└────────────────────────────────────────┘
+      (0,0)
+
+     where (0',0') = (0+x-origin,0+y-origin)
+
+    type: object
+
+    properties:
+      x-origin:
+        description: horizontal origin of the clipped area
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      y-origin:
+        description: vertical origin of the clipped area
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      x-size:
+        description: horizontal resolution of the clipped area
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      y-size:
+        description: vertical resolution of the clipped area
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+  virtual-buttons:
+    description: list of nodes defining the buttons on the touchscreen
+
+      This object can be used to describe buttons on the touchscreen area,
+      reporting the touch events on their surface as key events instead of
+      the original touch events.
+
+      This is of special interest if the touchscreen is shipped with a
+      physical overlay on top of it where a number of buttons with some
+      predefined functionality are printed. In that case a specific behavior
+      is expected from those buttons instead of raw touch events.
+
+      The virtual-buttons properties define a per-button area as well as an
+      origin relative to the real touchscreen origin. Touch events within the
+      button area are reported as the key event defined in the linux,code
+      property. Given that the key events do not provide coordinates, the
+      button origin is only used to place the button area on the touchscreen
+      surface. Any event outside the virtual-buttons object is reported as a
+      touch event with no coordinate transformation.
+
+      The following example shows a touchscreen with a single button on it
+
+              Touchscreen (full area)
+        ┌───────────────────────────────────┐
+        │                                   │
+        │                                   │
+        │   ┌─────────┐                     │
+        │   │button 0 │                     │
+        │   │KEY_POWER│                     │
+        │   └─────────┘                     │
+        │                                   │
+        │                                   │
+       ┌└───────────────────────────────────┘
+     (0,0)
+
+      The virtual-buttons object can  be combined with the virtual-touchscreen
+      object as shown in the following example. In that case only the events
+      within the virtual-touchscreen object are reported as touch events.
+
+                  Touchscreen (full area)
+        ┌─────────┬──────────────────────────────┐
+        │         │                              │
+        │         │    ┌───────────────────────┐ │
+        │ button 0│    │                       │ │
+        │KEY_POWER│    │                       │ │
+        │         │    │                       │ │
+        ├─────────┤    │  virtual-touchscreen  │ │
+        │         │    │                       │ │
+        │         │    │                       │ │
+        │ button 1│    │                       │ │
+        │ KEY_INFO│   ┌└───────────────────────┘ │
+        │         │(0',0')                       │
+       ┌└─────────┴──────────────────────────────┘
+     (0,0)
+
+    type: object
+
+    patternProperties:
+      '^button-':
+        type: object
+        description:
+          Each button (key) is represented as a sub-node.
+
+        properties:
+          label:
+            $ref: /schemas/types.yaml#/definitions/string
+            description: descriptive name of the button
+
+          linux,code: true
+
+          x-origin:
+            description: horizontal origin of the button area
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          y-origin:
+            description: vertical origin of the button area
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          x-size:
+            description: horizontal resolution of the button area
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          y-size:
+            description: vertical resolution of the button area
+            $ref: /schemas/types.yaml#/definitions/uint32
+
 dependencies:
   touchscreen-size-x: [ touchscreen-size-y ]
   touchscreen-size-y: [ touchscreen-size-x ]

-- 
2.39.2

